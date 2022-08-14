import 'package:args/command_runner.dart';
import 'package:obs_websocket/command.dart';

// Stream Requests
class ObsStreamCommand extends Command {
  @override
  String get description => 'Commands that manipulate OBS streams';

  @override
  String get name => 'stream';

  ObsStreamCommand() {
    addSubcommand(ObsGetStreamStatusCommand());
    addSubcommand(ObsToggleStreamCommand());
    addSubcommand(ObsStartStreamCommand());
    addSubcommand(ObsStopStreamCommand());
  }
}

/// Gets the status of the stream output.
class ObsGetStreamStatusCommand extends ObsHelperCommand {
  @override
  String get description => 'Gets the status of the stream output.';

  @override
  String get name => 'get-stream-status';

  @override
  void run() async {
    await initializeObs();

    final streamStatusResponse = await obs.stream.status;

    print(streamStatusResponse);

    obs.close();
  }
}

/// Toggles the status of the stream output.
class ObsToggleStreamCommand extends ObsHelperCommand {
  @override
  String get description => 'Toggles the status of the stream output.';

  @override
  String get name => 'toggle-stream';

  @override
  void run() async {
    await initializeObs();

    await obs.stream.toggleStream();

    obs.close();
  }
}

/// Starts the stream output.
class ObsStartStreamCommand extends ObsHelperCommand {
  @override
  String get description => 'Starts the stream output.';

  @override
  String get name => 'start-streaming';

  @override
  void run() async {
    await initializeObs();

    await obs.stream.startStream();

    obs.close();
  }
}

/// Stops the stream output.
class ObsStopStreamCommand extends ObsHelperCommand {
  @override
  String get description => 'Stops the stream output.';

  @override
  String get name => 'stop-streaming';

  @override
  void run() async {
    await initializeObs();

    await obs.stream.stopStream();

    obs.close();
  }
}
