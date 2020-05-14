import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/response.dart';

void main(List<String> args) async {
  final Config config = Config();

  Map<String, dynamic> params;

  config.initialize(args);

  await config.check();

  if (config.commandParams != null)
    try {
      params = jsonDecode(config.commandParams);
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }

  final SimpleResponse simpleResponse =
      await config.obsWebSocket.command(config.command, params);

  print(jsonEncode(simpleResponse.map));

  config.obsWebSocket.close();
}

class Config {
  ArgParser parser;

  bool showHelp = false;
  String passwd;
  ObsWebSocket obsWebSocket;
  String command;
  String commandParams;

  Config() {
    parser = ArgParser();
  }

  void initialize(List<String> args) {
    parser.addFlag("help",
        abbr: "h",
        negatable: false,
        help: "Display this helpful message", callback: (help) {
      this.showHelp = help;
    });
    parser.addOption("passwd",
        abbr: "p",
        help: "The OBS websocket password, only required if enabled in OBS",
        callback: (password) {
      this.passwd = password;
    });
    parser.addOption("url",
        abbr: "u",
        defaultsTo: "ws://127.0.0.1:4444",
        valueHelp: 'ws://[host]:[port]',
        help: "The url and port for OBS websocket", callback: (url) {
      this.obsWebSocket = ObsWebSocket(connectUrl: url);
    });
    parser.addOption("command",
        abbr: "c",
        help: "Required. The OBS command to send",
        allowed: [
          "StartStopStreaming",
          "StartStreaming",
          "StopStreaming",
          "GetStreamingStatus",
          "GetStreamSettings",
          "SetStreamSettings",
          "SaveStreamSettings"
        ], callback: (cmd) {
      this.command = cmd;
    });
    parser.addOption("args",
        abbr: "a",
        help:
            "Optional. The json encoded arguments for the supplied command if required",
        callback: (arguments) {
      this.commandParams = arguments;
    });

    try {
      parser.parse(args);
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }
  }

  void check() async {
    AuthRequired authRequired;

    if (showHelp || command == null) {
      print(parser.usage);
      exit(99);
    }

    try {
      authRequired = await obsWebSocket.getAuthRequired();
    } catch (se) {
      print(se);
      exit(99);
    }

    if (authRequired.status && passwd != null)
      await obsWebSocket.authenticate(authRequired, passwd);
    else if (passwd == null) {
      print(
          "OBS authentication has been enabled. A password is required for a successful connection, use --help for more options");
      exit(99);
    }
  }
}
