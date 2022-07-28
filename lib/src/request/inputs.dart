import 'package:obs_websocket/obs_websocket.dart';

/// Inputs Requests
class Inputs {
  final ObsWebSocket obsWebSocket;

  Inputs(this.obsWebSocket);

  /// Removes an existing input.
  ///
  /// Note: Will immediately remove all associated scene items.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> removeInput(String inputName) async => await remove(inputName);

  /// Removes an existing input.
  ///
  /// Note: Will immediately remove all associated scene items.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> remove(String inputName) async {
    await obsWebSocket.sendRequest(Request(
      'RemoveInput',
      requestData: {'inputName': inputName},
    ));
  }

  /// Sets the name of an input (rename).
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setInputName(
          {required String inputName, required String newInputName}) async =>
      await setName(inputName: inputName, newInputName: newInputName);

  /// Sets the name of an input (rename).
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setName(
      {required String inputName, required String newInputName}) async {
    await obsWebSocket.sendRequest(Request(
      'SetInputName',
      requestData: {'inputName': inputName},
    ));
  }
}
