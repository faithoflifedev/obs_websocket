import 'package:args/command_runner.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/src/cmd/obs_authorize_command.dart';
import 'package:universal_io/io.dart';

void main(List<String> arguments) async {
  CommandRunner('obs', 'A command line interface for controlling OBS.')
    ..argParser.addOption('uri',
        abbr: 'u',
        valueHelp: 'ws://[host]:[port]',
        help: 'The url and port for OBS websocket')
    ..argParser.addOption('passwd',
        abbr: 'p',
        valueHelp: 'string',
        help: 'The OBS websocket password, only required if enabled in OBS')
    ..addCommand(ObsAuthorizeCommand())
    ..addCommand(ObsGeneralCommand())
    // ..addCommand(ObsMediaControlCommand())
    ..addCommand(ObsSourcesCommand())
    // ..addCommand(ObsProfilesCommand())
    // ..addCommand(ObsRecordingCommand())
    // ..addCommand(ObsSceneItemsCommand())
    // ..addCommand(ObsScenesCommand())
    ..addCommand(ObsStreamingCommand())
    // ..addCommand(ObsStudioModeCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;

      print(error);

      exit(64); // Exit code 64 indicates a usage error.
    });
}
