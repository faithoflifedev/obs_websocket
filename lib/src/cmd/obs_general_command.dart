import 'package:args/command_runner.dart';
import 'package:obs_websocket/command.dart';

/// General Requests
class ObsGeneralCommand extends Command {
  @override
  String get description => 'General commands';

  @override
  String get name => 'general';

  ObsGeneralCommand() {
    addSubcommand(ObsGetVersionCommand());
    addSubcommand(ObsGetStatsCommand());
    // addSubcommand(ObsBroadcastCustomEventCommand());
    // addSubcommand(ObsCallVendorRequestCommand());
    // addSubcommand(ObsGetHotkeyListCommand());
    // addSubcommand(ObsTriggerHotkeyByNameCommand());
    // addSubcommand(ObsTriggerHotkeyByKeySequenceCommand());
    // addSubcommand(ObSleepCommand());
  }
}

/// Gets data about the current plugin and RPC version.
class ObsGetVersionCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Gets data about the current plugin and RPC version.';

  @override
  String get name => 'get-version';

  @override
  void run() async {
    await initializeObs();

    final versionResponse = await obs.general.version();

    print(versionResponse);

    obs.close();
  }
}

/// Gets statistics about OBS, obs-websocket, and the current session.
class ObsGetStatsCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Gets statistics about OBS, obs-websocket, and the current session.';

  @override
  String get name => 'get-stats';

  @override
  void run() async {
    await initializeObs();

    final statsResponse = await obs.general.stats();

    print(statsResponse);

    obs.close();
  }
}
