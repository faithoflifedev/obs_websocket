import 'package:obs_websocket/obsWebsocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  final config = loadYaml(File('config.yaml').readAsStringSync());

  ObsWebSocket obsWebSocket = await ObsWebSocket.connect(
      connectUrl: config['host'],
      timeout: const Duration(seconds: 5),
      fallbackEvent: (event) {
        print('event: ${event.rawEvent}');
      });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, config['password']);
  }

  final status = await obsWebSocket.getStreamStatus();

  print('status: ${status.streaming}');
}
