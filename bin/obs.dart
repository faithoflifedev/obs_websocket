import 'package:args/command_runner.dart';
import 'package:obs_websocket/command.dart';
import 'package:obs_websocket/src/util/validate.dart';
import 'package:universal_io/io.dart';

void main(List<String> arguments) async {
  CommandRunner('obs', 'A command line interface for controlling OBS.')
    ..argParser.addOption('uri',
        abbr: 'u',
        valueHelp: 'ws://[host]:[port]',
        help: 'The url and port for OBS websocket')
    ..argParser.addOption('timeout',
        abbr: 't',
        valueHelp: 'int',
        help: 'The timeout in seconds for the web socket connection.',
        callback: (value) =>
            Validate.isNull(value) || Validate.isGreaterOrEqual(value, 1))
    ..argParser.addOption('log-level',
        abbr: 'l',
        allowed: ['all', 'debug', 'info', 'warning', 'error', 'off'],
        defaultsTo: 'off')
    ..argParser.addOption('passwd',
        abbr: 'p',
        valueHelp: 'string',
        help: 'The OBS websocket password, only required if enabled in OBS')
    ..addCommand(ObsAuthorizeCommand())
    ..addCommand(ObsListenCommand())
    ..addCommand(ObsGeneralCommand())
    ..addCommand(ObsConfigCommand())
    ..addCommand(ObsSendCommand())
    ..addCommand(ObsSourcesCommand())
    // ..addCommand(ObsProfilesCommand())
    // ..addCommand(ObsRecordingCommand())
    // ..addCommand(ObsSceneItemsCommand())
    // ..addCommand(ObsScenesCommand())
    ..addCommand(ObsStreamCommand())
    // ..addCommand(ObsStudioModeCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;

      print(error);

      exit(64); // Exit code 64 indicates a usage error.
    });
}
