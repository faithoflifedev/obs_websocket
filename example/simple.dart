import 'package:obs_websocket/obs_websocket.dart';
// import 'package:universal_io/io.dart';
// import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  // final config = loadYaml(File('config.yaml').readAsStringSync());

  ObsWebSocket obsWebSocket = await ObsWebSocket.connect(
      connectUrl: 'ws://192.168.1.84:4444',
      timeout: const Duration(seconds: 5),
      fallbackEvent: (event) {
        print('event: ${event.rawEvent}');
      });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, 'test');
  }

  final status = await obsWebSocket.getStreamStatus();

  print('status: ${status.streaming}');
}
