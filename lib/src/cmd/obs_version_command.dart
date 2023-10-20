import 'package:args/command_runner.dart';
import 'package:obs_websocket/meta.dart';

/// Generate a refresh token used to authenticate the command line API requests
class ObsVersionCommand extends Command {
  @override
  String get description => 'Display the package name and version';

  @override
  String get name => 'version';

  @override
  void run() async {
    print('${pubSpec['name']} v${pubSpec['version']}');
  }
}
