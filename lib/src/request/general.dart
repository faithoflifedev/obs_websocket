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
  Future<VersionResponse> getVersion() async => await version();

  /// Gets data about the current plugin and RPC version.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<VersionResponse> version() async {
    final response = await obsWebSocket.sendRequest(Request('GetVersion'));

    return VersionResponse.fromJson(response!.responseData!);
  }

  /// Gets statistics about OBS, obs-websocket, and the current session.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StatsResponse> getStats() async => await stats();

  /// Gets statistics about OBS, obs-websocket, and the current session.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StatsResponse> stats() async {
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

  // TODO:
  Future<void> getHotkeyList() async => throw UnimplementedError();

  // TODO:
  Future<void> triggerHotkeyByName() async => throw UnimplementedError();

  // TODO:
  Future<void> triggerHotkeyByKeySequence() async => throw UnimplementedError();

  // TODO:
  Future<void> sleep() async => throw UnimplementedError();
}
