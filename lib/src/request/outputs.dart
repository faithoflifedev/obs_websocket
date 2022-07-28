import 'package:obs_websocket/obs_websocket.dart';

/// Outputs Requests
class Outputs {
  final ObsWebSocket obsWebSocket;

  Outputs(this.obsWebSocket);

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
