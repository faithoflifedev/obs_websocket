import 'package:obs_websocket/obsWebsocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  //get connection infomration from the config.yaml file
  final config = loadYaml(File('example/config.yaml').readAsStringSync());

  ObsWebSocket obsWebSocket = ObsWebSocket(
      connectUrl: config['host'],
      onEvent: (BaseEvent event) {
        print('streaming: ${event.rawEvent}');
      });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, config['password']);
  }

  final status = await obsWebSocket.getStreamStatus();

  if (status.streaming) {
    obsWebSocket.startStopStreaming();
  }

  // final setting =
  //     StreamSetting.fromJson(config['stream'].cast<Map<String, dynamic>>());

  final setting = StreamSetting.fromJson({
    'type': 'rtmp_custom',
    'settings': {'server': '[rtmp_url]', 'key': '[stream_key]'}
  });

  await obsWebSocket.setStreamSettings(setting);

  final streamSettings = await obsWebSocket.getStreamSettings();

  print(streamSettings.settings.toString());

  //using the old v1.x lower lovel methods
  final response = await obsWebSocket.command('StartStreaming');

  //Alternatively, the helper method could be used
  //await obsWebSocket.startStreaming();

  if (response != null) {
    print(response.status);
  }

  obsWebSocket.close();
}
