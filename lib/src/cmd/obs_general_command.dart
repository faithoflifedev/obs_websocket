import 'package:args/command_runner.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsGeneralCommand extends Command {
  @override
  String get description => 'General commands';

  @override
  String get name => 'general';

  ObsGeneralCommand() {
    addSubcommand(ObsGetAuthRequiredCommand());
    // addSubcommand(OnvifGetProfilesMediaCommand());
    // addSubcommand(OnvifGetSnapshotUriMediaCommand());
    // addSubcommand(OnvifGetStreamUriMediaCommand());
    // addSubcommand(OnvifGetVideoSourcesMediaCommand());
    // addSubcommand(OnvifStartMulticastStreamingMediaCommand());
    // addSubcommand(OnvifStopMulticastStreamingMediaCommand());
  }
}

///Tells the client if authentication is required. If so, returns authentication
///parameters challenge and salt (see "Authentication" for more information).
class ObsGetAuthRequiredCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Tells the client if authentication is required. If so, returns authentication parameters challenge and salt (see "Authentication" for more information).';

  @override
  String get name => 'get-auth-required';

  @override
  void run() async {
    await initializeObs();

    // final authRequiredResponse = await obs.getAuthRequired();

    // print(authRequiredResponse);

    obs.close();
  }
}
