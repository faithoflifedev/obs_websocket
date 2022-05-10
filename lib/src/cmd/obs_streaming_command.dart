import 'package:args/command_runner.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsStreamingCommand extends Command {
  @override
  String get description => 'Commands that manipulate OBS streaming';

  @override
  String get name => 'streaming';

  ObsStreamingCommand() {
    addSubcommand(ObsGetStreamingStatusStreamingCommand());
    addSubcommand(ObsStartStopStreamingStreamingCommand());
    addSubcommand(ObsStartStreamingStreamingCommand());
    addSubcommand(ObsStopStreamingStreamingCommand());
    addSubcommand(ObsSetStreamSettingsStreamingCommand());
    addSubcommand(ObsGetStreamSettingsStreamingCommand());
    addSubcommand(ObsSaveStreamSettingsStreamingCommand());
  }
}

///Get current streaming and recording status.
class ObsGetStreamingStatusStreamingCommand extends ObsHelperCommand {
  @override
  String get description => 'Get current streaming and recording status.';

  @override
  String get name => 'get-stream-status';

  @override
  void run() async {
    await initializeObs();

    final streamStatusResponse = await obs.getStreamStatus();

    print(streamStatusResponse);

    obs.close();
  }
}

///Toggle streaming on or off (depending on the current stream state).
class ObsStartStopStreamingStreamingCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Toggle streaming on or off (depending on the current stream state).';

  @override
  String get name => 'start-stop-streaming';

  @override
  void run() async {
    await initializeObs();

    await obs.startStopStreaming();

    obs.close();
  }
}

///Start streaming. Will return an error if streaming is not active.
class ObsStartStreamingStreamingCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Start streaming. Will return an error if streaming is not active.';

  @override
  String get name => 'start-streaming';

  @override
  void run() async {
    await initializeObs();

    await obs.startStreaming();

    obs.close();
  }
}

///Stop streaming. Will return an error if streaming is not active.
class ObsStopStreamingStreamingCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Stop streaming. Will return an error if streaming is not active.';

  @override
  String get name => 'stop-streaming';

  @override
  void run() async {
    await initializeObs();

    await obs.stopStreaming();

    obs.close();
  }
}

///Sets one or more attributes of the current streaming server settings. Any
///options not passed will remain unchanged. Returns the updated settings in
///response. If 'type' is different than the current streaming service type, all
///settings are required. Returns the full settings of the stream (the same as
///GetStreamSettings).
class ObsSetStreamSettingsStreamingCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Sets one or more attributes of the current streaming server settings.';

  @override
  String get name => 'set-stream-settings';

  ObsSetStreamSettingsStreamingCommand() {
    argParser
      ..addOption('type',
          defaultsTo: 'rtmp_custom',
          allowed: ['rtmp_custom', 'rtmp_common'],
          help:
              'The type of streaming service configuration, usually rtmp_custom or rtmp_common.')
      ..addOption('server', help: 'The publish URL.')
      ..addOption('key', help: 'The publish key.')
      ..addFlag('save',
          defaultsTo: false, help: 'Persist the settings to disk.');
  }

  @override
  void run() async {
    await initializeObs();

    StreamSetting streamSetting = StreamSetting(
        type: argResults!['type'],
        settings: StreamSettings(
            server: argResults?['server'], key: argResults?['key']),
        save: argResults!['save']);

    await obs.setStreamSettings(streamSetting);

    obs.close();
  }
}

///Get the current streaming server settings.
class ObsGetStreamSettingsStreamingCommand extends ObsHelperCommand {
  @override
  String get description => 'Get the current streaming server settings.';

  @override
  String get name => 'get-stream-settings';

  @override
  void run() async {
    await initializeObs();

    final streamSettingsResponse = await obs.getStreamSettings();

    print(streamSettingsResponse);

    obs.close();
  }
}

///Save the current streaming server settings to disk.
class ObsSaveStreamSettingsStreamingCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Save the current streaming server settings to disk.';

  @override
  String get name => 'save-stream-settings';

  @override
  void run() async {
    await initializeObs();

    await obs.saveStreamSettings();

    obs.close();
  }
}
