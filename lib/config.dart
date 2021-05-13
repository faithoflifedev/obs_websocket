import 'dart:convert';

import 'package:args/args.dart';
import 'package:obs_websocket/obsWebsocket.dart';
import 'package:obs_websocket/src/model/authRequiredResponse.dart';
import 'package:universal_io/io.dart';

class Config {
  late final ArgParser parser;

  bool showHelp = false;
  late final String passwd;
  late final ObsWebSocket obsWebSocket;
  late final String command;
  late final String commandParams;
  late final Map<String, dynamic>? params;
  late final File _commandFile;

  Config() {
    parser = ArgParser();
  }

  File get commandFile => _commandFile;

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
      this.passwd = password!;
    });
    parser.addOption("url",
        abbr: "u",
        defaultsTo: "ws://127.0.0.1:4444",
        valueHelp: 'ws://[host]:[port]',
        help: "The url and port for OBS websocket", callback: (url) {
      obsWebSocket = ObsWebSocket(connectUrl: url!);
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
          "SaveStreamSettings",
          "GetSourcesList",
          "GetSourceSettings",
          "GetVolume",
          "SetVolume",
          "GetCurrentSceneCollection",
          "ListSceneCollections",
          "GetSceneList",
          "GetCurrentScene",
          "SetCurrentScene",
          "EnableStudioMode",
          "TransitionToProgram",
          "SetPreviewScene",
          "GetPreviewScene",
          "GetStudioModeStatus",
          "EnableStudioMode",
          "DisableStudioMode",
          "GetSceneItemProperties"
        ], callback: (cmd) {
      this.command = cmd!;
    });
    parser.addOption("args",
        abbr: "a",
        help:
            "Optional. The json encoded arguments for the supplied command if required",
        callback: (arguments) {
      this.commandParams = arguments!;
    });
    // parser.addOption("file",
    //     abbr: "f",
    //     help:
    //         "Optional. File with a set of commands and args. If included these commands will run after any given with --command",
    //     callback: (file) {
    //   if (file != null) {
    //     _commandFile =
    //         (FileSystemEntity.typeSync(file) != FileSystemEntityType.notFound)
    //             ? File(file)
    //             : null;
    //   }
    // });

    try {
      parser.parse(args);
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }
  }

  Future<void> check() async {
    AuthRequiredResponse? authRequired;

    if (showHelp) {
      print(parser.usage);
      exit(99);
    }

    authRequired = await obsWebSocket.getAuthRequired();

    if (!authRequired.status) {
      print('Could not determine authentication requirements');
      exit(99);
    }

    if (authRequired.status)
      await obsWebSocket.authenticate(authRequired, passwd);
    else {
      print(
          "OBS authentication has been enabled. A password is required for a successful connection, use --help for more options");
      exit(99);
    }

    try {
      params = jsonDecode(commandParams);
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }
  }
}
