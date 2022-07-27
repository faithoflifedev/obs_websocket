import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  // get connection information from the config.yaml file
  final config = loadYaml(File('config.yaml').readAsStringSync());

  ObsWebSocket obsWebSocket = await ObsWebSocket.connect(
    config['host'],
    password: config['password'],
    fallbackEventHandler: (Event event) {
      print('event: ${event.eventData}');
    },
  );

  obsWebSocket.addHandler<RecordStateChanged>(
      (RecordStateChanged recordStateChanged) =>
          print('recording output active: ${recordStateChanged.outputActive}'));

  obsWebSocket.addHandler<SceneItemSelected>(
      (SceneItemSelected sceneItemSelected) =>
          print('scene item: ${sceneItemSelected.sceneName}'));

  obsWebSocket.addHandler<SceneItemEnableStateChanged>(
      (SceneItemEnableStateChanged sceneItemEnableStateChanged) => print(
          'scene item state: ${sceneItemEnableStateChanged.sceneItemEnabled}'));

  obsWebSocket.addHandler<StreamStateChanged>(
      (StreamStateChanged streamStateEvent) =>
          print('stream state: ${streamStateEvent.outputState}'));

  // obsWebSocket.addHandler<StreamStatusEvent>((StreamStatusEvent streamStatus) =>
  //     print('stream status (total frames): ${streamStatus.numTotalFrames}'));

  final status = await obsWebSocket.stream.status();

  if (!status.outputActive) {
    final streamServiceSettings = StreamServiceSettings(
        streamServiceType: 'rtmp_custom',
        streamServiceSettings: {'server': '[rtmp_url]', 'key': '[stream_key]'});

    await obsWebSocket.config.setStreamServiceSettings(streamServiceSettings);

    obsWebSocket.stream.start();
  }

  // final streamServiceSettings = await obsWebSocket.getStreamServiceSettings();

  await obsWebSocket.record.toggle();

  //using the old v1.x lower level methods
  // final response = await obsWebSocket.command('StopStreaming');

  // if (response != null) {
  //   print(response.status);
  // }

  //Alternatively, the helper method could be used
  // await obsWebSocket.stopStreaming();

  // print(streamSettings.settings.toString());

  obsWebSocket.close();
}
