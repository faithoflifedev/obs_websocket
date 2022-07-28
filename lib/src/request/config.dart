import 'package:obs_websocket/obs_websocket.dart';

/// Config Requests
class Config {
  final ObsWebSocket obsWebSocket;

  Config(this.obsWebSocket);

  Future<void> get persistentData async => getPersistentData;
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

  /// Switches to a profile.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setCurrentProfile(String profileName) async =>
      await obsWebSocket.sendRequest(Request(
        'SetCurrentProfile',
        requestData: {'profileName': profileName},
      ));

  /// Creates a new profile, switching to it in the process
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> createProfile(String profileName) async =>
      await obsWebSocket.sendRequest(Request(
        'CreateProfile',
        requestData: {'profileName': profileName},
      ));

  /// Removes a profile. If the current profile is chosen, it will change to a different profile first.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> removeProfile(String profileName) async =>
      await obsWebSocket.sendRequest(Request(
        'RemoveProfile',
        requestData: {'profileName': profileName},
      ));

  // TODO:
  Future<void> getProfileParameter() async => throw UnimplementedError();

  // TODO:
  Future<void> setProfileParameter() async => throw UnimplementedError();

  /// Gets the current video settings.
  ///
  /// Note: To get the true FPS value, divide the FPS numerator by the FPS denominator. Example: 60000/1001
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<VideoSettingsResponse> getVideoSettings() async => videoSettings();

  /// Gets the current video settings.
  ///
  /// Note: To get the true FPS value, divide the FPS numerator by the FPS denominator. Example: 60000/1001
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<VideoSettingsResponse> videoSettings() async {
    final response =
        await obsWebSocket.sendRequest(Request('GetVideoSettings'));

    return VideoSettingsResponse.fromJson(response!.responseData!);
  }

  /// Sets the current video settings.
  ///
  /// - Complexity Rating: 2/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setVideoSettings(VideoSettings videoSettings) async =>
      await obsWebSocket.sendRequest(Request(
        'SetVideoSettings',
        requestData: videoSettings.toJson(),
      ));

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
