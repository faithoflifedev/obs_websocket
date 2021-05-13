import 'package:obs_websocket/obsWebsocket.dart';

void main(List<String> args) async {
  final sceneItem = 'ytBell';

  ObsWebSocket obsWebSocket = ObsWebSocket(
      connectUrl: "ws://192.168.1.84:4444",
      onEvent: (BaseEvent event, ObsWebSocket obsWebSocket) async {
        // print('streaming: ${event.rawEvent}');

        if (event.updateType == 'SceneItemVisibilityChanged') {
          final sceneItemVisibilityChanged =
              event.asSceneItemVisibilityChangedEvent();

          if (sceneItemVisibilityChanged.itemName == sceneItem &&
              sceneItemVisibilityChanged.itemVisible) {
            final args = sceneItemVisibilityChanged.asArgs()
              ..['render'] = 'false';

            await Future.delayed(Duration(seconds: 13));

            await obsWebSocket.setSceneItemRender(args);

            await obsWebSocket.close();
          }
        }
      });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, "test");
  }

  final currentScene = await obsWebSocket.getCurrentScene();

  final sceneDetail = currentScene.getSceneDetail(withName: sceneItem);

  if (sceneDetail == null) {
    throw Exception();
  }
  ;

  if (sceneDetail.render) {
    await obsWebSocket
        .setSceneItemRender({'source': sceneItem, 'render': false});
  }

  await obsWebSocket.setSceneItemRender({'source': sceneItem, 'render': true});

  //obsWebSocket.close();
}
