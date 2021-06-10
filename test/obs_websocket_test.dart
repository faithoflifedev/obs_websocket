import 'package:obs_websocket/obsWebsocket.dart';
import 'package:test/test.dart';

void main() {
  test('ObsWebSocket should not be null', () async {
    ObsWebSocket obsWebSocket = await ObsWebSocket.connect(connectUrl: '');

    expect(obsWebSocket.message_id, 0);
  });
}
