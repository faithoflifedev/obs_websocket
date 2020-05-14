import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/response.dart';

void main(List<String> args) async {
  ObsWebSocket obsWebSocket = ObsWebSocket(connectUrl: "ws://localhost:4444");

  final AuthRequired authRequired = await obsWebSocket.getAuthRequired();

  SimpleResponse response;

  if (authRequired.status) {
    await obsWebSocket.authenticate(authRequired, "mySecretDontTell");
  }

  response = await obsWebSocket.command("StartStreaming");

  print(response.status);

  response = await obsWebSocket.command("GetSourcesList");

  List sources = response.map["sources"];

  sources.forEach((source) => print(source["name"] + " - " + source["type"]));

  response = await obsWebSocket
      .command("GetSourceSettings", {"sourceName": "slide-top"});

  Map newSettings = Map<String, dynamic>.from(response.map);

  newSettings["sourceSettings"]["height"] = 1080;
  newSettings["sourceSettings"]["width"] = 1920;

  response = await obsWebSocket.command("SetSourceSettings", newSettings);

  print(response.map);

  obsWebSocket.close();
}
