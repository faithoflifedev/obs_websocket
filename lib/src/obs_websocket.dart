import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:obs_websocket/obsWebsocket.dart';
import 'package:obs_websocket/src/model/authRequiredResponse.dart';
import 'package:obs_websocket/src/model/mediaStateResponse.dart';
import 'package:obs_websocket/src/model/scene.dart';
import 'package:obs_websocket/src/model/streamSetting.dart';
import 'package:obs_websocket/src/model/streamSettingsResponse.dart';
import 'package:obs_websocket/src/model/streamStatusResponse.dart';
import 'package:obs_websocket/src/model/studioModeStatus.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ObsWebSocket {
  final String connectUrl;

  final WebSocketChannel channel;

  late final Stream<dynamic> broadcast;

  final List<Function> listeners = [];

  int message_id = 0;

  ///When the object is created we open the websocket connection and create a
  ///broadcast stream so that we can have multiple listeners providing responses
  ///to commands. [connectUrl] is in the format 'ws://host:port'.
  ObsWebSocket({required this.connectUrl, Function? onEvent})
      : channel = WebSocketChannel.connect(Uri.parse(connectUrl)) {
    broadcast = channel.stream.asBroadcastStream();

    if (onEvent != null) {
      addListener(onEvent);
    }

    broadcast.listen((jsonEvent) {
      final Map<String, dynamic> rawEvent = jsonDecode(jsonEvent);

      if (!rawEvent.containsKey('message-id') && listeners.isNotEmpty) {
        listeners.forEach((listener) async =>
            await listener(BaseEvent.fromJson(rawEvent), this));
      }
    });
  }

  /// Before execution finished the websocket needs to be closed
  Future<void> close() async {
    await channel.sink.close(status.goingAway);
  }

  void addListener(Function listener) {
    listeners.add(listener);
  }

  ///Returns an AuthRequiredResponse object that can be used to determine if
  ///authentication is required to connect to the server.  The
  ///AuthRequiredResponse object hods the 'salt' and 'secret' that will be
  ///required for authentication in the case that it is required throws an
  ///[Exception] if there is a problem or error returned by the server.
  Future<AuthRequiredResponse> getAuthRequired() async {
    var authRequired = AuthRequiredResponse.init();

    var messageId = sendCommand({'request-type': 'GetAuthRequired'});

    await for (String message in broadcast) {
      authRequired = AuthRequiredResponse.fromJson(jsonDecode(message));

      if (!authRequired.status) {
        throw Exception(
            'Server returned error to GetAuthRequiredResponse request: $message');
      }

      if (authRequired.messageId == messageId) {
        break;
      }
    }

    return authRequired;
  }

  ///Returns a BaseResponse object, [requirements] are provided by the
  ///AuthRequiredResponse object and [passwd] is the password assigned in the
  ///OBS interface for websockets. If OBS returns an error in the response, then
  ///an [Exception] will be thrown.
  Future<BaseResponse?> authenticate(
      AuthRequiredResponse requirements, String passwd) async {
    final secret = base64Hash(passwd + requirements.salt!);
    final auth_reponse = base64Hash(secret + requirements.challenge!);

    BaseResponse? response;

    var messageId =
        sendCommand({'request-type': 'Authenticate', 'auth': auth_reponse});

    await for (String message in broadcast) {
      response = BaseResponse.fromJson(jsonDecode(message));

      if (!response.status) {
        throw Exception(
            'Server returned error to Authenticate request: $message');
      }

      if (response.messageId == messageId) {
        break;
      }
    }

    return response;
  }

  ///This is a helper method for sending commands over the websocket.  A
  ///SimpleResponse is returned.  The function requires a [command] from the
  ///documented list of websocket and optionally [args] can be provided  if
  ///required by the command.  If OBS returns an error in the response, then an
  ///[Exception] will be thrown.
  Future<BaseResponse?> command(String command,
      [Map<String, dynamic>? args]) async {
    BaseResponse? response;

    var messageId = sendCommand({'request-type': command}, args);

    await for (String message in broadcast) {
      response = BaseResponse.fromJson(jsonDecode(message));

      if (!response.status && response.messageId == messageId) {
        throw Exception('Server returned error to $command request: $message');
      }

      if (response.messageId == messageId) {
        break;
      }
    }

    return response;
  }

  ///This is the lower level send that transmits the command supplied on the
  ///websocket, It requires a [payload], the command as a Map that will be  json
  ///encoded in the format required by OBS, and the [args].  Both are combined
  ///into a single Map that is json encoded and transmitted over the websocket.
  String sendCommand(Map<String, dynamic> payload,
      [Map<String, dynamic>? args]) {
    message_id++;

    payload['message-id'] = message_id.toString();

    if (args != null) {
      payload.addAll(args);
    }

    final requestPayload = jsonEncode(payload);

    channel.sink.add(requestPayload);

    return message_id.toString();
  }

  ///Get current streaming and recording status.
  Future<StreamStatusResponse> getStreamStatus() async {
    var response = await command('GetStreamingStatus');

    if (response == null) {
      throw Exception('Could not retrieve the stream status');
    }

    return StreamStatusResponse.fromJson(response.rawResponse);
  }

  ///Stop streaming. Will return an error if streaming is not active.
  Future<void> stopStreaming() async {
    await command('StopStreaming');
  }

  ///Start streaming. Will return an error if streaming is already active.
  Future<void> startStreaming() async {
    await command('StartStreaming');
  }

  ///Toggle streaming on or off (depending on the current stream state).
  Future<void> startStopStreaming() async {
    await command('StartStopStreaming');
  }

  ///Get the current streaming server settings.
  Future<StreamSettingsResponse> getStreamSettings() async {
    final response = await command('GetStreamSettings');

    if (response == null) {
      throw Exception('Problem getting stream settings');
    }

    return StreamSettingsResponse.fromJson(response.rawResponse);
  }

  ///Sets one or more attributes of the current streaming server settings. Any
  ///options not passed will remain unchanged. Returns the updated settings in
  ///'response'. If 'type' is different than the current streaming service type,
  ///all settings are required. Returns the full settings of the stream (the
  ///same as 'GetStreamSettings').
  Future<void> setStreamSettings(StreamSetting streamSetting) async {
    await command('SetStreamSettings', streamSetting.toJson());
  }

  ///Enables Studio Mode.
  Future<void> enableStudioMode() async {
    await command('EnableStudioMode');
  }

  ///Indicates if Studio Mode is currently enabled.
  Future<StudioModeStatus> getStudioModeStatus() async {
    final response = await command('GetStudioModeStatus');

    if (response == null) {
      throw Exception('Problem getting stream settings');
    }

    return StudioModeStatus.fromJson(response.rawResponse);
  }

  ///Get the current scene's name and source items.
  Future<Scene> getCurrentScene() async {
    final response = await command('GetCurrentScene');

    if (response == null) {
      throw Exception('Problem getting current scene');
    }

    return Scene.fromJson(response.rawResponse);
  }

  ///Switch to the specified scene.
  Future<void> setCurrentScene(Map<String, dynamic> args) async {
    await command('SetCurrentScene', args);
  }

  ///Show or hide a specified source item in a specified scene.
  Future<void> setSceneItemRender(Map<String, dynamic> args) async {
    await command('SetSceneItemRender', args);
  }

  // Future<List<Scene>> getSceneList([Map<String, dynamic>? args]) async {
  //   final response = await command('GetSceneList', args);

  //   return null;
  // }

  ///Pause or play a media source. Supports ffmpeg and vlc media sources (as of
  ///OBS v25.0.8) Note :Leaving out playPause toggles the current pause state
  Future<void> playPauseMedia([Map<String, dynamic>? args]) async {
    await command('PlayPauseMedia', args);
  }

  ///Restart a media source. Supports ffmpeg and vlc media sources (as of OBS
  ///v25.0.8)
  Future<void> restartMedia([Map<String, dynamic>? args]) async {
    await command('RestartMedia', args);
  }

  ///Stop a media source. Supports ffmpeg and vlc media sources (as of OBS
  ///v25.0.8)
  Future<void> stopMedia([Map<String, dynamic>? args]) async {
    await command('StopMedia', args);
  }

  ///Get the current playing state of a media source. Supports ffmpeg and vlc
  ///media sources (as of OBS v25.0.8)
  Future<MediaStateResponse> getMediaState([Map<String, dynamic>? args]) async {
    final response = await command('GetMediaState', args);

    if (response == null) {
      throw Exception('Problem getting media state');
    }

    return MediaStateResponse.fromJson(response.rawResponse);
  }

  ///A helper function that encrypts authentication info [data] for the purpose of
  ///authentication.
  String base64Hash(String data) {
    final hash = sha256.convert(utf8.encode(data));

    final secret = base64.encode(hash.bytes);

    return secret;
  }
}
