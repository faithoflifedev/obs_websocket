import 'package:obs_websocket/obs_websocket.dart';

/// Outputs Requests
class Outputs {
  final ObsWebSocket obsWebSocket;

  Outputs(this.obsWebSocket);

  /// Gets the status of the virtualcam output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getVirtualCamStatus() async {
    final response =
        await obsWebSocket.sendRequest(Request('GetVirtualCamStatus'));

    return OutputActive.fromJson(response!.responseData!).enabled;
  }

  /// Toggles the state of the virtualcam output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> toggleVirtualCam() async {
    final response =
        await obsWebSocket.sendRequest(Request('ToggleVirtualCam'));

    return OutputActive.fromJson(response!.responseData!).enabled;
  }

  /// Starts the virtualcam output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> startVirtualCam() async =>
      await obsWebSocket.sendRequest(Request('StartVirtualCam'));

  /// Stops the virtualcam output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> stopVirtualCam() async =>
      await obsWebSocket.sendRequest(Request('StopVirtualCam'));

  /// Gets the status of the replay buffer output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getReplayBufferStatus() async {
    final response =
        await obsWebSocket.sendRequest(Request('ToggleVirtualCam'));

    return OutputActive.fromJson(response!.responseData!).enabled;
  }

  /// Starts an output.
  ///
  /// - Complexity Rating: 4/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> startOutput(String outputName) async => await start(outputName);

  /// Starts an output.
  ///
  /// - Complexity Rating: 4/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> start(String outputName) async =>
      await obsWebSocket.sendRequest(Request('StartOutput'));

  /// Stops an output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> stopOutput(String outputName) async => await stop(outputName);

  /// Stops an output.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> stop(String outputName) async =>
      await obsWebSocket.sendRequest(Request('StopOutput'));
}
