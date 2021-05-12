import 'package:obs_websocket/obsWebsocket.dart';

void main(List<String> args) async {
  ObsWebSocket obsWebSocket = ObsWebSocket(
      connectUrl: "ws://192.168.1.84:4444",
      onEvent: (BaseEvent event) {
        print('streaming: ${event.rawEvent}');
      });

  var authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, "test");
  }

  var status = await obsWebSocket.getStreamStatus();

  if (!status.streaming) {
    final setting = StreamSetting.fromJson({
      'type': 'rtmp_custom',
      'settings': {
        'server': 'rtmp://localhost/live',
        'key': 'e799f8a080cd11ea8ab98d27449157a9'
      }
    });

    await obsWebSocket.setStreamSettings(setting);
  }

  var streamSettings = await obsWebSocket.getStreamSettings();

  print(streamSettings.settings.toString());

  obsWebSocket.close();
}
