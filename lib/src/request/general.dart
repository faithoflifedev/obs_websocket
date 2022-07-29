import 'package:obs_websocket/obs_websocket.dart';

/// General Requests
class General {
  final ObsWebSocket obsWebSocket;

  General(this.obsWebSocket);

  /// Gets data about the current plugin and RPC version.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<VersionResponse> get version async => await getVersion();

  /// Gets data about the current plugin and RPC version.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<VersionResponse> getVersion() async {
    final response = await obsWebSocket.sendRequest(Request('GetVersion'));

    return VersionResponse.fromJson(response!.responseData!);
  }

  /// Gets statistics about OBS, obs-websocket, and the current session.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StatsResponse> get stats async => await getStats();

  /// Gets statistics about OBS, obs-websocket, and the current session.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StatsResponse> getStats() async {
    final response = await obsWebSocket.sendRequest(Request('GetStats'));

    return StatsResponse.fromJson(response!.responseData!);
  }

  // TODO:
  Future<void> broadcastCustomEvent(Map<String, dynamic> arg) async =>
      await obsWebSocket.sendRequest(Request(
        'BroadcastCustomEvent',
        requestData: arg,
      ));

  // TODO:
  Future<void> callVendorRequest() async => throw UnimplementedError();

  ///Gets an array of all hotkey names in OBS
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<String>> get hotkeyList async => await getHotkeyList();

  ///Gets an array of all hotkey names in OBS
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<String>> getHotkeyList() async {
    final response = await obsWebSocket.sendRequest(Request('GetHotkeyList'));

    return Hotkeys.fromJson(response!.responseData!).items;
  }

  Future<void> triggerHotkeyByName(String hotkeyName) async {
    await obsWebSocket.sendRequest(Request(
      'TriggerHotkeyByName',
      requestData: {'hotkeyName': hotkeyName},
    ));
  }

  // TODO:
  Future<void> triggerHotkeyByKeySequence() async => throw UnimplementedError();

  // TODO:
  Future<void> sleep() async => throw UnimplementedError();
}
