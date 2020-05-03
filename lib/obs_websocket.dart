import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:obs_websocket/response.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ObsWebSocket {
  final String connectUrl;

  IOWebSocketChannel channel;

  Stream<dynamic> broadcast;

  int message_id = 0;

  ///When the object is created we open the websocket connection and create a broadcast
  ///stream so that we can have multiple listeners providing responses to commands.
  ///[connectUrl] is in the format 'ws://host:port'.
  ObsWebSocket({@required this.connectUrl}) {
    channel = IOWebSocketChannel.connect(connectUrl);

    broadcast = channel.stream.asBroadcastStream();
  }

  /// Before execution finished the websocket needs to be closed
  void close() {
    channel.sink.close(status.goingAway);
  }

  ///Returns an AuthRequired object that can be used to determine if authentication is 
  ///required to connect to the server.  The AuthRequired object hods the 'salt' and
  ///'secret' that will be required for authentication in the case that it is required
  ///Throws an [Exception] if there is a problem or error returned by the server.
  Future<AuthRequired> getAuthRequired() async {
    AuthRequired authRequired;

    int messageId = sendCommand({'request-type': 'GetAuthRequired'});

    await for (String message in broadcast) {
      authRequired = AuthRequired.fromJson(jsonDecode(message));

      if (!authRequired.status) {
        throw Exception(
            'Server returned error to GetAuthRequired request: ${message}');
      }

      if (authRequired.messageId == messageId) break;
    }

    return authRequired;
  }

  ///Returns a SimpleResponse object, [requirements] are provided by the AuthRequired
  ///object and [passwd] is the password assigned in the OBS interface for websockets
  ///If OBS returns an error in the response, then an [Exception] will be thrown.
  Future<SimpleResponse> authenticate(
      AuthRequired requirements, String passwd) async {
    final String secret = base64Hash(passwd + requirements.salt);
    final String auth_reponse = base64Hash(secret + requirements.challenge);

    SimpleResponse response;

    int messageId =
        sendCommand({"request-type": "Authenticate", "auth": auth_reponse});

    await for (String message in broadcast) {
      response = SimpleResponse.fromJson(jsonDecode(message));

      if (!response.status) {
        throw Exception(
            'Server returned error to GetAuthRequired request: ${message}');
      }

      if (response.messageId == messageId) break;
    }

    return response;
  }

  ///This is a helper method for sending commands over the websocket.  A SimpleResponse
  ///is returned.  The function requires a [command] from the documented list of 
  ///websocket and optionally [args] can be provided if rquired by the command.  If OBS 
  ///returns an error in the response, then an [Exception] will be thrown.
  Future<SimpleResponse> command(String command, [Map<String,dynamic> args]) async {
    SimpleResponse response;

    int messageId = sendCommand({"request-type": command}, args);

    await for (String message in broadcast) {
      response = SimpleResponse.fromJson(jsonDecode(message));

      if (!response.status) {
        throw Exception(
            'Server returned error to ${command} request: ${message}');
      }

      if (response.messageId == messageId) break;
    }

    return response;
  }

  ///This is the lower level send that transmits the command supplied on the websocket,  
  ///It requires a [payload], the command as a Map that will be json encoded in the 
  ///format required by OBS, and the [args].  Both are combined into a single Map that
  ///is json encoded and transmitted over the websocket.
  int sendCommand(Map<String, dynamic> payload,[Map<String,dynamic> args]) {
    message_id++;

    payload["message-id"] = message_id.toString();

    if (args != null)
    payload.addAll(args);

    final String requestPayload = jsonEncode(payload);

    channel.sink.add(requestPayload);

    return message_id;
  }

  ///A helper function that encrypts authentication info [data] for the purpose of
  ///authentication.
  String base64Hash(String data) {
    final Digest hash = sha256.convert(utf8.encode(data));

    final String secret = base64.encode(hash.bytes);

    return secret;
  }
}
