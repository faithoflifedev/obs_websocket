import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  final config = loadYaml(File('config.yaml').readAsStringSync());

  final sceneItem = 'opsLower';

  ObsWebSocket obsWebSocket =
      await ObsWebSocket.connect(connectUrl: config['host']);

  //this handler will only run when a SceneItemState event is generated
  obsWebSocket
      .addHandler<SceneItemState>((SceneItemState sceneItemState) async {
    print('event: ${sceneItemState.sceneName} ${sceneItemState.state}');

    //make sure we have the correct sceneItem and that it's currently visible
    if (sceneItemState.type == 'SceneItemVisibilityChanged' &&
        sceneItemState.itemName == sceneItem &&
        sceneItemState.state) {
      //wait 13 seconds
      await Future.delayed(Duration(seconds: 13));

      //hide the sceneItem
      await obsWebSocket
          .setSceneItemRender(sceneItemState.toSceneItemRenderMap(false));

      //close the socket when complete
      await obsWebSocket.close();
    }
  });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, config['password']);
  }

  final currentScene = await obsWebSocket.getCurrentScene();

  final sceneDetail = currentScene.getSceneDetail(withName: sceneItem);

  if (sceneDetail == null) {
    throw Exception();
  }

  if (sceneDetail.render) {
    await obsWebSocket
        .setSceneItemRender({'source': sceneItem, 'render': false});
  }

  await obsWebSocket.setSceneItemRender({'source': sceneItem, 'render': true});

  //obsWebSocket.close();
}
