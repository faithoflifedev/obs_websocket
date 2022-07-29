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
  Future<int> getId({
    required String sceneName,
    required String sourceName,
    int? searchOffset,
  }) async =>
      await getId(
        sceneName: sceneName,
        sourceName: sourceName,
        searchOffset: searchOffset,
      );

  /// Searches a scene for a source, and returns its id.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<int> getSceneItemId({
    required String sceneName,
    required String sourceName,
    int? searchOffset,
  }) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetSceneItemId',
      requestData: {
        'sceneName': sceneName,
        'sourceName': sourceName,
        'searchOffset': searchOffset,
      }..removeWhere((key, value) => value == null),
    ));

    return SceneItemId.fromJson(response!.responseData!).itemId;
  }

  /// Gets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getSceneItemEnabled(
          {required String sceneName, required int sceneItemId}) async =>
      getEnabled(
        sceneName: sceneName,
        sceneItemId: sceneItemId,
      );

  /// Gets the enable state of a scene item.
  ///
  /// Scenes and Groups
  ///
  /// - Complexity Rating: 3/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  Future<bool> getEnabled({
    required String sceneName,
    required int sceneItemId,
  }) async {
    final response = await obsWebSocket.sendRequest(Request(
      'GetSceneItemEnabled',
      requestData: {
        'sceneName': sceneName,
        'sceneItemId': sceneItemId,
      },
    ));

    return SceneItemEnabled.fromJson(response!.responseData!).enabled;
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
