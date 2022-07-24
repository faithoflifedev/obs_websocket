import 'dart:convert';

import 'package:loggy/loggy.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/src/connect.dart';
import 'package:obs_websocket/src/request/config.dart';
import 'package:obs_websocket/src/request/stream.dart' as obs;
import 'package:obs_websocket/src/request/record.dart';
import 'package:obs_websocket/src/request/general.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ObsWebSocket with UiLoggy {
  final WebSocketChannel websocketChannel;

  final Stream broadcastStream;

  final String? password;

  final List<Function> fallbackHandlers = [];

  final eventHandlers = <String, List<Function>>{};

  obs.Stream? _stream;

  Record? _record;

  General? _general;

  Config? _config;

  bool handshakeComplete = false;

  int? _negotiatedRpcVersion;

  int messageId = 0;

  int get negotiatedRpcVersion => handshakeComplete
      ? _negotiatedRpcVersion!
      : throw Exception('authentication not completed');

  obs.Stream get stream => _stream!;

  Record get record => _record!;

  General get general => _general!;

  Config get config => _config!;

  static Map<int, int> opCodeResponseMap = {
    WebSocketOpCode.identify.code: WebSocketOpCode.identified.code,
    WebSocketOpCode.request.code: WebSocketOpCode.requestResponse.code,
    WebSocketOpCode.requestBatch.code:
        WebSocketOpCode.requestBatchResponse.code,
  };

  ///When the object is created we open the websocket connection and create a
  ///broadcast stream so that we can have multiple listeners providing responses
  ///to commands. [channel] is an existing [WebSocketChannel].
  ObsWebSocket(
    this.websocketChannel, {
    this.password,
    Function()? onDone,
    Function? fallbackEvent,
  }) : broadcastStream = websocketChannel.stream.asBroadcastStream() {
    _stream = obs.Stream(this);

    _record = Record(this);

    _general = General(this);

    _config = Config(this);
  }

  static Future<ObsWebSocket> connect(
    String connectUrl, {
    String? password,
    Duration timeout = const Duration(seconds: 120),
    Function()? onDone,
    Function? fallbackEvent,
  }) async {
    if (!connectUrl.startsWith('ws://')) {
      connectUrl = 'ws://$connectUrl';
    }

    logDebug('connecting');

    final webSocketChannel =
        await Connect().connect(connectUrl: connectUrl, timeout: timeout);

    final obsWebSocket = ObsWebSocket(
      webSocketChannel,
      password: password,
      onDone: onDone,
      fallbackEvent: fallbackEvent,
    );

    logDebug('connected');

    await obsWebSocket.init();

    return obsWebSocket;
  }

  Future<void> init() async {
    broadcastStream.listen((message) {
      final opcode = Opcode.fromJson(json.decode(message));

      if (opcode.op == WebSocketOpCode.event.code) {
        final event = Event.fromJson(opcode.d);
        print('event: $event');

        _handleEvent(event);
      }
    });

    await authenticate();
  }

  Future<void> authenticate() async {
    loggy.debug('authenticating');

    final helloOpcode = await getStreamOpcode(WebSocketOpCode.hello.code);

    if (helloOpcode == null) {
      throw Exception('Authentication error with Hello response');
    }

    final hello = Hello.fromJson(helloOpcode.d);

    final Authentication? authentication = hello.authentication;

    String? authToken;

    if (authentication != null) {
      final secret = ObsUtil.base64Hash('$password${authentication.salt}');

      authToken = ObsUtil.base64Hash('$secret${authentication.challenge}');
    }

    final identifyOpcode = Identify(
      rpcVersion: hello.rpcVersion,
      authentication: authToken,
      eventSubscriptions: EventSubscription.none.code,
    ).toOpcode();

    final identifiedOpcode = await sendOpcode(identifyOpcode);

    if (identifiedOpcode == null) {
      throw Exception('Authentication error with identified response');
    }

    final identified = Identified.fromJson(identifiedOpcode.d);

    _negotiatedRpcVersion = identified.negotiatedRpcVersion;

    handshakeComplete = true;

    loggy.debug('negotiatedRpcVersion: $negotiatedRpcVersion');

    loggy.debug('authenticated');
  }

  Future<Opcode?> getStreamOpcode(int? webSocketOpCode) async {
    Opcode? opcode;

    if (webSocketOpCode == null) {
      return null;
    }

    await for (String message in broadcastStream) {
      loggy.debug('rcv raw opcode: $message');

      opcode = Opcode.fromJson(json.decode(message));

      if (opcode.op == webSocketOpCode) {
        return opcode;
      }
    }

    return opcode;
  }

  Future<Opcode?> sendOpcode(Opcode opcode) async {
    loggy.debug('send opcode: $opcode');

    websocketChannel.sink.add(opcode.toString());

    return await getStreamOpcode(opCodeResponseMap[opcode.op]);
  }

  Future<void> listen(EventSubscription eventSubscription) async {
    final reIdentifyOpcode = ReIdentifyOpcode(
        ReIdentify(eventSubscriptions: eventSubscription.code));

    await sendOpcode(reIdentifyOpcode);
  }

  /// Look at the raw [event] data and run the appropriate event handler
  void _handleEvent(Event event) {
    final listeners = eventHandlers[event.eventType] ?? [];

    switch (event.eventType) {
      case 'SceneItemEnableStateChanged':
        for (var handler in listeners) {
          handler(SceneItemEnableStateChanged.fromJson(event.eventData));
        }

        break;

      default:
        _fallback(event);
    }
  }

  ///Before execution finished the websocket needs to be closed
  Future<void> close() async {
    await websocketChannel.sink.close(status.goingAway);
  }

  ///Add an event handler for the event type [T]
  void addHandler<T>(Function listener) {
    eventHandlers['$T'] ??= <Function>[];

    eventHandlers['$T']?.add(listener);
  }

  ///Remove an event handler for the event type [T]
  void removeHandler<T>(Function listener) {
    eventHandlers['$T'] ??= <Function>[];

    eventHandlers['$T']?.remove(listener);
  }

  ///Add an event handler for an event that don't have a specific class
  void addFallbackListener(Function listener) {
    fallbackHandlers.add(listener);
  }

  ///Remove an event handler for an event that don't have a specific class
  void removeFallbackListener(Function listener) {
    fallbackHandlers.remove(listener);
  }

  ///Handler when none of the others match the event class
  void _fallback(Event event) {
    for (var handler in fallbackHandlers) {
      handler(event.eventData);
    }
  }

  // Future<RequestResponse?> command(String command,
  //         [Map<String, dynamic>? args]) async =>
  //     await sendRequest(Request(requestType: command, requestData: args));

  Future<RequestResponse?> sendRequest(Request request) async {
    RequestResponse? requestResponse;

    loggy.debug('send ${request.requestType}: ${request.toOpcode()}');

    websocketChannel.sink.add(request.toOpcode().toString());

    await for (String message in broadcastStream) {
      final response = Opcode.fromJson(json.decode(message));

      loggy.debug('response raw: $message');
      if (response.op == WebSocketOpCode.requestResponse.code) {
        requestResponse = RequestResponse.fromJson(response.d);

        loggy.debug(
            'response status: ${requestResponse.requestType} ${requestResponse.requestStatus}');
        if (request.requestId == request.requestId) {
          _checkResponse(request, requestResponse.responseData);

          break;
        }
      }
    }

    return requestResponse;
  }

  void _checkResponse(Request request, Map<String, dynamic>? responseData) {
    if (request.hasResponseData && responseData == null) {
      throw Exception('Problem with command: ${request.requestType}');
    }
  }

  /// Gets the current program scene.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<String> getCurrentProgramScene() async {
    final response = await sendRequest(Request('GetCurrentProgramScene'));

    final currentProgramSceneResponse =
        CurrentProgramSceneResponse.fromJson(response!.responseData!);

    return currentProgramSceneResponse.currentProgramSceneName;
  }

  /// Sets the current program scene.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setCurrentProgramScene(String sceneName) async =>
      await sendRequest(Request(
        'SetCurrentProgramScene',
        requestData: {'sceneName': sceneName},
      ));

  /// Searches a scene for a source, and returns its id.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<int> getSceneItemId(SceneItemId sceneItemId) async {
    final response = await sendRequest(Request(
      'GetSceneItemId',
      requestData: sceneItemId.toJson(),
    ));

    final sceneItemIdResponse =
        SceneItemIdResponse.fromJson(response!.responseData!);

    return sceneItemIdResponse.sceneItemId;
  }

  /// Gets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getSceneItemEnabled(SceneItemEnabled sceneItemEnabled) async {
    final response = await sendRequest(Request(
      'GetSceneItemEnabled',
      requestData: sceneItemEnabled.toJson(),
    ));

    final sceneItemEnabledResponse =
        SceneItemEnabledResponse.fromJson(response!.responseData!);

    return sceneItemEnabledResponse.sceneItemEnabled;
  }

  /// Sets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setSceneItemEnabled(
          SceneItemEnableStateChanged sceneItemEnableStateChanged) async =>
      await sendRequest(Request(
        'SetSceneItemEnabled',
        requestData: sceneItemEnableStateChanged.toJson(),
      ));
}
