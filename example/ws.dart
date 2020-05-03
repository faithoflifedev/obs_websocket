import 'package:args/args.dart';
import 'package:obsWebsocket/obsWebsocket.dart';
import 'package:obsWebsocket/response.dart';

void main(List<String> args) async {
  final ArgParser parser = ArgParser();

  parser.addOption("passwd", abbr: "p");
  parser.addOption("command",
      abbr: "c",
      allowed: ["StartStopStreaming", "StartStreaming", "StopStreaming", "GetStreamingStatus"]);

  ArgResults argResult = parser.parse(args);

  ObsWebSocket obsWebSocket = ObsWebSocket(connectUrl: "ws://192.168.1.94:4444");

  final AuthRequired authRequired = await obsWebSocket.getAuthRequired();

  if (authRequired.status)
    await obsWebSocket.authenticate(authRequired, argResult["passwd"]);

  if (argResult["command"] != "") await obsWebSocket.command(argResult["command"]);

  obsWebSocket.close();
}


