import 'package:loggy/loggy.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

main() async {
  final config = loadYaml(File('config.yaml').readAsStringSync());

  final obs = await ObsWebSocket.connect(
    config['host'],
    password: config['password'],
    logOptions: LogOptions(LogLevel.debug),
    fallbackEventHandler: (Event event) =>
        print('type: ${event.eventType} data: ${event.eventData}'),
    onDone: () => print('done'),
  );

  var vol = await obs.inputs.getInputVolume(inputName: 'Media Source');

  print(vol.inputVolumeMul);

  var res = await obs.outputs.toggleReplayBuffer();

  print(res);

  final currentScene = await obs.scenes.getCurrentProgramScene();

  // get the id of the required sceneItem
  final sceneItemId = await obs.sceneItems.getSceneItemId(
    sceneName: currentScene,
    sourceName: 'my face',
  );

  final indexId = await obs.sceneItems
      .getIndex(sceneName: currentScene, sceneItemId: sceneItemId);

  print(indexId);

  await obs.sceneItems.setIndex(
      sceneName: currentScene, sceneItemId: sceneItemId, sceneItemIndex: 4);

  final versionResponse = await obs.general.version;

  print(versionResponse.obsWebSocketVersion);

  var response = await obs.send('GetHotkeyList');

  // use a helper method to make a request
  final streamStatusResponse = await obs.stream.status;

  print('is streaming: ${streamStatusResponse.outputActive}');

  // the low-level method of making a request
  response = await obs.send('GetStreamStatus');

  print('request status: ${response?.requestStatus.result}');

  print('is streaming: ${response?.responseData?['outputActive']}');

  response = await obs.send('GetSceneList');

  // helper equivalent
  // final sceneListResponse = await obs.scenes.list();

  var scenes = response?.responseData?['scenes'];

  scenes.forEach(
      (scene) => print('${scene['sceneName']} - ${scene['sceneIndex']}'));

  // helper equivalent...
  // for (var scene in sceneListResponse.scenes) {
  //   print('${scene.sceneName} - ${scene.sceneIndex}');
  // }

  var groups = await obs.scenes.getGroupList();

  for (var group in groups) {
    print(group);
  }

  var sceneItems = await obs.sceneItems.getSceneItemList('Scene');

  for (var sceneItem in sceneItems) {
    print('id: ${sceneItem.sceneItemId}, sourceName ${sceneItem.sourceName}');
  }

  var groupSceneItems = await obs.sceneItems.groupList('Group');

  for (var groupSceneItem in groupSceneItems) {
    print(
        'id: ${groupSceneItem.sceneItemId}, sourceName ${groupSceneItem.sourceName}');
  }

  var newSettings =
      Map<String, dynamic>.from(response?.responseData as Map<String, dynamic>);

  newSettings.addAll({
    'baseWidth': 1440,
    'baseHeight': 1080,
    'outputWidth': 1440,
    'outputHeight': 1080
  });

  response = await obs.send('SetVideoSettings', newSettings);

  print('$response');

  // await obs.scenes.setCurrentProgramScene('presentation');

  final statsResponse = await obs.general.stats;

  print('cpu usage: ${statsResponse.cpuUsage}');

  final sourceScreenshotResponse =
      await obs.sources.screenshot(SourceScreenshot(
    sourceName: 'my face',
    imageFormat: 'jpeg',
  ));

  File('screen_shot.jpeg').writeAsBytesSync(sourceScreenshotResponse.bytes);

  // don't close the connection since we want to continue to receive events
  // only close once OBS is exited.
  obs.addHandler<ExitStarted>(() async {
    print('obs exiting');

    //not really necessary since OBS is going away anyway
    await obs.close();
  });
}
