import 'package:obs_websocket/obs_websocket.dart';

/// Record Requests
class SceneItems {
  final ObsWebSocket obsWebSocket;

  SceneItems(this.obsWebSocket);

  /// Gets a list of all scene items in a scene.
  ///
  /// Scenes only
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<SceneItemDetail>> getSceneItemList(String sceneName) async =>
      await list(sceneName);

  /// Gets a list of all scene items in a scene.
  ///
  /// Scenes only
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<SceneItemDetail>> list(String sceneName) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetSceneItemList',
      requestData: {'sceneName': sceneName},
    ));

    final sceneItemListResponse =
        SceneItemListResponse.fromJson(response!.responseData!);

    return sceneItemListResponse.sceneItems;
  }

  /// Basically GetSceneItemList, but for groups.
  ///
  /// Using groups at all in OBS is discouraged, as they are very broken under the hood.
  ///
  /// Groups only
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<SceneItemDetail>> getGroupSceneItemList(String sceneName) async =>
      await groupList(sceneName);

  /// Basically GetSceneItemList, but for groups.
  ///
  /// Using groups at all in OBS is discouraged, as they are very broken under the hood.
  ///
  /// Groups only
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<List<SceneItemDetail>> groupList(String sceneName) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetGroupSceneItemList',
      requestData: {'sceneName': sceneName},
    ));

    final sceneItemListResponse =
        SceneItemListResponse.fromJson(response!.responseData!);

    return sceneItemListResponse.sceneItems;
  }

  /// Searches a scene for a source, and returns its id.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<int> getSceneItemId(SceneItemId sceneItemId) async =>
      await getId(sceneItemId);

  /// Searches a scene for a source, and returns its id.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<int> getId(SceneItemId sceneItemId) async {
    final response = await obsWebSocket.sendRequest(Request(
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
  Future<bool> getSceneItemEnabled(SceneItemEnabled sceneItemEnabled) async =>
      getEnabled(sceneItemEnabled);

  /// Gets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getEnabled(SceneItemEnabled sceneItemEnabled) async {
    final response = await obsWebSocket.sendRequest(Request(
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
      setEnabled(sceneItemEnableStateChanged);

  /// Sets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<void> setEnabled(
          SceneItemEnableStateChanged sceneItemEnableStateChanged) async =>
      await obsWebSocket.sendRequest(Request(
        'SetSceneItemEnabled',
        requestData: sceneItemEnableStateChanged.toJson(),
      ));
}
