import 'package:args/args.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/response.dart';

void main(List<String> args) async {
  final ArgParser parser = ArgParser();

  parser.addOption("passwd", abbr: "p");
  parser.addOption("connect", abbr: "c");

  ArgResults argResult = parser.parse(args);

  ObsWebSocket obsWebSocket = ObsWebSocket(connectUrl: argResult["connect"]);

  final AuthRequired authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status)
    await obsWebSocket.authenticate(authRequired, argResult["passwd"]);

  SimpleResponse response = await obsWebSocket.command("GetSourcesList");

  List sources = response.map["sources"];

  sources.forEach((source) => print(source["name"] + " " + source["type"]));

  response = await obsWebSocket.command("GetSourceSettings", { "sourceName": "foreground" });

  print(response.map);

  Map newSettings = Map<String,dynamic>.from(response.map);

  newSettings["sourceSettings"]["height"] = 1080;
  newSettings["sourceSettings"]["width"] = 1920;

  response = await obsWebSocket.command("SetSourceSettings", newSettings);

  print(response.map);

  obsWebSocket.close();
}
