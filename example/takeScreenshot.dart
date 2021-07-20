import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  final config = loadYaml(File('config.yaml').readAsStringSync());

  ObsWebSocket obsWebSocket =
      await ObsWebSocket.connect(connectUrl: config['host']);

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.authRequired != false) {
    await obsWebSocket.authenticate(authRequired, config['password']);
  }

  final takeSourceScreenshot = TakeSourceScreenshot(
      sourceName: 'main',
      saveToFilePath: '/Users/av/Movies/takeSourceScreenshot.jpg',
      width: 720);

  final response =
      await obsWebSocket.takeSourceScreenshot(takeSourceScreenshot);

  print(response);

  await obsWebSocket.refreshBrowserSource('opsLower');

  await obsWebSocket.saveStreamSettings();

  obsWebSocket.close();
}
