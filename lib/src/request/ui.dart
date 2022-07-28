import 'package:obs_websocket/obs_websocket.dart';

/// Stream Requests
class Ui {
  final ObsWebSocket obsWebSocket;

  Ui(this.obsWebSocket);

  /// Enables or disables studio mode
  ///
  ///  - Complexity Rating: 1/5
  ///  - Latest Supported RPC Version: 1
  ///  - Added in v5.0.0
  Future<bool> getStudioModeEnabled() async {
    final response =
        await obsWebSocket.sendRequest(Request('GetStudioModeEnabled'));

    final studioModeEnabled =
        StudioModeEnabledResponse.fromJson(response!.responseData!);

    return studioModeEnabled.studioModeEnabled;
  }

  /// Enables or disables studio mode
  ///
  ///  - Complexity Rating: 1/5
  ///  - Latest Supported RPC Version: 1
  ///  - Added in v5.0.0
  Future<void> setStudioModeEnabled(bool studioModeEnabled) async =>
      await obsWebSocket.sendRequest(Request(
        'SetStudioModeEnabled',
        requestData: {'studioModeEnabled': studioModeEnabled},
      ));

  // TODO:
  Future<void> openInputPropertiesDialog() async => throw UnimplementedError();

  // TODO:
  Future<void> openInputInteractDialog() async => throw UnimplementedError();

  // TODO:
  Future<void> getMonitorList() async => throw UnimplementedError();

  // TODO:
  Future<void> openVideoMixProjector() async => throw UnimplementedError();

  // TODO:
  Future<void> openSourceProjector() async => throw UnimplementedError();
}
