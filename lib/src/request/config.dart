import 'package:obs_websocket/obs_websocket.dart';

/// Config Requests
class Config {
  final ObsWebSocket obsWebSocket;

  Config(this.obsWebSocket);

  // TODO:
  Future<void> getPersistentData() async => throw UnimplementedError();

  // TODO:
  Future<void> setPersistentData() async => throw UnimplementedError();

  // TODO:
  Future<void> getSceneCollectionList() async => throw UnimplementedError();

  // TODO:
  Future<void> setSceneCollectionList() async => throw UnimplementedError();

  // TODO:
  Future<void> createSceneCollection() async => throw UnimplementedError();

  // TODO:
  Future<void> getProfileList() async => throw UnimplementedError();

  // TODO:
  Future<void> setCurrentProfile() async => throw UnimplementedError();

  // TODO:
  Future<void> createProfile() async => throw UnimplementedError();

  // TODO:
  Future<void> removeProfile() async => throw UnimplementedError();

  // TODO:
  Future<void> getProfileParameter() async => throw UnimplementedError();

  // TODO:
  Future<void> setProfileParameter() async => throw UnimplementedError();

  // TODO:
  Future<void> getVideoSettings() async => throw UnimplementedError();

  // TODO:
  Future<void> setVideoSettings() async => throw UnimplementedError();

  /// Gets the current stream service settings (stream destination).
  ///
  /// - Complexity Rating: 4/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StreamServiceSettingsResponse> getStreamServiceSettings() async =>
      await streamServiceSettings();

  /// Gets the current stream service settings (stream destination).
  ///
  /// - Complexity Rating: 4/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<StreamServiceSettingsResponse> streamServiceSettings() async {
    final response =
        await obsWebSocket.sendRequest(Request('GetStreamServiceSettings'));

    return StreamServiceSettingsResponse.fromJson(response!.responseData!);
  }

  /// Sets the current stream service settings (stream destination).
  ///
  /// Note: Simple RTMP settings can be set with type rtmp_custom and the settings fields server and key.
  ///
  /// - Complexity Rating: 4/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setStreamServiceSettings(
          StreamServiceSettings streamServiceSettings) async =>
      await obsWebSocket.sendRequest(Request(
        'SetStreamServiceSettings',
        requestData: streamServiceSettings.toJson(),
      ));
}
