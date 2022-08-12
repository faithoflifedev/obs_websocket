import 'package:args/command_runner.dart';
import 'package:obs_websocket/src/util/meta.dart';

/// Generate a refresh token used to authenticate the command line API requests
class ObsVersionCommand extends Command {
  @override
  String get description => 'Display the package name and version';

  @override
  String get name => 'version';

  @override
  void run() async {
    print('${meta['name']} v${meta['version']}');
  }
}
