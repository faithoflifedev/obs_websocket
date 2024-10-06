import 'package:obs_websocket/obs_websocket.dart';

/// Inputs Requests
class Inputs {
  final ObsWebSocket obsWebSocket;

  Inputs(this.obsWebSocket);

  /// Gets an array of all inputs in OBS.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<Input>> getInputList(String? inputKind) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetInputList',
      requestData: {'inputKind': inputKind}
        ..removeWhere((key, value) => value == null),
    ));

    if (response == null || response.responseData == null) return <Input>[];

    return InputKindResponse.fromJson(response.responseData!).inputs;
  }

  /// Gets an array of all available input kinds in OBS.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<String>> getInputKindList([bool unversioned = false]) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetInputKindList',
      requestData: {'unversioned': unversioned}
        ..removeWhere((key, value) => value == null),
    ));

    if (response == null || response.responseData == null) return <String>[];

    return response.responseData?['inputKinds']?.cast<String>() ?? <String>[];
  }

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
  Future<void> remove(String inputName) async =>
      await obsWebSocket.sendRequest(Request(
        'RemoveInput',
        requestData: {'inputName': inputName},
      ));

  /// Sets the name of an input (rename).
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setInputName({
    required String inputName,
    required String newInputName,
  }) async =>
      await setName(
        inputName: inputName,
        newInputName: newInputName,
      );

  /// Sets the name of an input (rename).
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setName({
    required String inputName,
    required String newInputName,
  }) async {
    await obsWebSocket.sendRequest(Request(
      'SetInputName',
      requestData: {
        'inputName': inputName,
        'newInputName': newInputName,
      },
    ));
  }

  /// Gets the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getMute(String inputName) async => getInputMute(inputName);

  /// Gets the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getInputMute(String inputName) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetInputMute',
      requestData: {'inputName': inputName},
    ));

    return BooleanResponse.fromJson(response!.responseData!).enabled;
  }

  /// Sets the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setMute({
    required String inputName,
    required bool inputMuted,
  }) =>
      setInputMute(
        inputName: inputName,
        inputMuted: inputMuted,
      );

  /// Sets the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setInputMute({
    required String inputName,
    required bool inputMuted,
  }) async =>
      await obsWebSocket.sendRequest(Request(
        'SetInputMute',
        requestData: {
          'inputName': inputName,
          'inputMuted': inputMuted,
        },
      ));

  /// Toggles the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> toggleMute(String inputName) async => toggleInputMute(inputName);

  /// Toggles the audio mute state of an input.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> toggleInputMute(String inputName) async {
    final response = await obsWebSocket.sendRequest(Request(
      'ToggleInputMute',
      requestData: {'inputName': inputName},
    ));

    return BooleanResponse.fromJson(response!.responseData!).enabled;
  }

  /// Gets the current volume setting of an input.
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<InputVolumeResponse> getInputVolume({
    String? inputName,
    String? inputUuid,
  }) async {
    if (inputName == null && inputUuid == null) {
      throw ArgumentError('inputName or inputUuid must be provided');
    }

    final response = await obsWebSocket.sendRequest(Request(
      'GetInputVolume',
      requestData: {
        'inputName': inputName,
        'inputUuid': inputUuid,
      }..removeWhere((key, value) => value == null),
    ));

    return InputVolumeResponse.fromJson(response!.responseData!);
  }
}
