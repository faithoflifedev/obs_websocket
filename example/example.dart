import 'package:obs_websocket/obsWebsocket.dart';

void main(List<String> args) async {
  ObsWebSocket obsWebSocket = ObsWebSocket(
      connectUrl: "ws://192.168.1.84:4444",
      onEvent: (BaseEvent event) {
        print('streaming: ${event.rawEvent}');
      });

  final authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, "test");
  }

  final status = await obsWebSocket.getStreamStatus();

  if (status.streaming) {
    obsWebSocket.startStopStreaming();
  }

  final setting = StreamSetting.fromJson({
    'type': 'rtmp_custom',
    'settings': {
      'server': 'rtmp://localhost/live',
      'key': 'e799f8a080cd11ea8ab98d27449157a9'
    }
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
