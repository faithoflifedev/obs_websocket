import 'dart:convert';

import 'package:args/args.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';

void main(List<String> args) async {
  final config = Config();

  await config.initialize(args);

  await config.check();

  final baseResponse =
      await config.obsWebSocket.command(config.command, config.jsonParams);

  if (baseResponse != null) {
    print('${baseResponse.rawResponse}');
  }

  await config.obsWebSocket.close();
}

class Config {
  final ArgParser parser = ArgParser();

  // late final ObsWebSocket obsWebSocket;
  late final String command;
  late final ObsWebSocket obsWebSocket;

  String? passwd;
  String? commandParams;
  String? url;
  Map<String, dynamic>? jsonParams;

  bool showHelp = false;

  Future<void> initialize(List<String> args) async {
    parser.addFlag('help',
        abbr: 'h',
        negatable: false,
        help: 'Display this helpful message', callback: (help) {
      showHelp = help;
    });

    parser.addOption('passwd',
        abbr: 'p',
        help: 'The OBS websocket password, only required if enabled in OBS',
        callback: (password) {
      passwd = password;
    });

    parser.addOption('url',
        abbr: 'u',
        // defaultsTo: 'ws://127.0.0.1:4444',
        valueHelp: 'ws://[host]:[port]',
        help: 'The url and port for OBS websocket', callback: (url) async {
      if (url != null) {
        this.url = url;
      } else {
        print(
            'You need to supply a url for this to work, use --help for more options');
      }
    });

    parser.addOption('command',
        abbr: 'c',
        help: 'Required. The OBS command to send',
        allowed: [
          'StartStopStreaming',
          'StartStreaming',
          'StopStreaming',
          'GetStreamingStatus',
          'GetStreamSettings',
          'SetStreamSettings',
          'SaveStreamSettings',
          'GetMediaSourcesList',
          'GetSourcesList',
          'GetSourceActive',
          'GetAudioActive',
          'GetVolume',
          'SetVolume'
        ], callback: (cmd) {
      if (cmd != null) {
        command = cmd;
      } else {
        print(
            'You need to supply a command for this to work, use --help for more options');
      }
    });

    parser.addOption('args',
        abbr: 'a',
        help:
            'Optional. The json encoded arguments for the supplied command if required',
        callback: (arguments) {
      commandParams = arguments;
    });

    try {
      parser.parse(args);
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }
  }

  Future<void> check() async {
    if (showHelp) {
      print(parser.usage);
      exit(99);
    }

    obsWebSocket = await ObsWebSocket.connect(connectUrl: url!);

    final authRequired = await obsWebSocket.getAuthRequired();

    if (!authRequired.status) {
      print('Could not determine authentication requirements');
      print(parser.usage);
      exit(99);
    }

    if (authRequired.status && passwd != null) {
      await obsWebSocket.authenticate(authRequired, passwd!);
    } else {
      print(
          'OBS authentication has been enabled. A password is required for a successful connection, use --help for more options');
      print(parser.usage);
      exit(99);
    }

    try {
      if (commandParams != null) {
        jsonParams = jsonDecode(commandParams!);
      }
    } on FormatException catch (fe) {
      print(fe);
      exit(99);
    }
  }
}
