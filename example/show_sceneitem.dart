import 'package:loggy/loggy.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  Loggy.initLoggy();
  final config = loadYaml(File('config.yaml').readAsStringSync());

  final sceneItem = 'My Face';

  ObsWebSocket obsWebSocket =
      await ObsWebSocket.connect(config['host'], password: config['password']);

  obsWebSocket.listen(EventSubscription.all);

  final currentScene = await obsWebSocket.getCurrentProgramScene();

  final sceneItemId = await obsWebSocket.getSceneItemId(SceneItemId(
    sceneName: currentScene,
    sourceName: sceneItem,
  ));

  final hideScene = SceneItemEnableStateChanged(
      sceneName: currentScene,
      sceneItemId: sceneItemId,
      sceneItemEnabled: false);

  final showScene = SceneItemEnableStateChanged(
      sceneName: currentScene,
      sceneItemId: sceneItemId,
      sceneItemEnabled: true);

  // this handler will only run when a SceneItemEnableStateChanged event is generated
  obsWebSocket.addHandler<SceneItemEnableStateChanged>(
      (SceneItemEnableStateChanged sceneItemEnableStateChanged) async {
    print(
        'event: ${sceneItemEnableStateChanged.sceneName} ${sceneItemEnableStateChanged.sceneItemEnabled}');

    // make sure we have the correct sceneItem and that it's currently visible
    if (sceneItemEnableStateChanged.sceneName == currentScene &&
        sceneItemEnableStateChanged.sceneItemEnabled) {
      // wait 13 seconds
      await Future.delayed(Duration(seconds: 13));

      // hide the sceneItem
      await obsWebSocket.setSceneItemEnabled(hideScene);

      // close the socket when complete
      await obsWebSocket.close();
    }
  });

  // start with scene hidden
  final sceneItemEnabled =
      await obsWebSocket.getSceneItemEnabled(SceneItemEnabled(
    sceneName: currentScene,
    sceneItemId: sceneItemId,
  ));

  if (sceneItemEnabled) {
    await obsWebSocket.setSceneItemEnabled(hideScene);
  }

  // now show the scene
  await obsWebSocket.setSceneItemEnabled(showScene);

  //obsWebSocket.close();
}
