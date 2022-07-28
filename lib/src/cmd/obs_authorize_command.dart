import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:obs_websocket/src/util/util.dart';
import 'package:universal_io/io.dart';

/// Generate a refresh token used to authenticate the command line API requests
class ObsAuthorizeCommand extends Command {
  @override
  String get description =>
      'Generate an authentication file for an OBS connection';

  @override
  String get name => 'authorize';

  @override
  void run() async {
    final credFile = File('${ObsUtil.userHome}/.obs/credentials.json');

    final hasCred = credFile.existsSync();

    String? approval;

    final credentials = <String, dynamic>{};

    if (hasCred) {
      print('Do you want to overwrite the default credentials [y/n]:');

      approval = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

      //use existing credentials from filesystem
      if (approval != null && approval.startsWith('n')) {
        final content = credFile.readAsStringSync();

        try {
          credentials.addAll(json.decode(content));
        } catch (exception) {
          stderr.write('Error reading the credentials file.\n');

          exit(64);
        }
      }
    }

    print('Uri (ws://[host]:[port]):');

    credentials['uri'] =
        stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    print('Password:');

    stdin.echoMode = false;

    credentials['password'] =
        stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    if (credentials['uri'] == null || credentials['password'] == null) {
      throw Exception('Error: missing required data.');
    }

    credFile.createSync(recursive: true);

    credFile.writeAsString(json.encode(credentials));

    print('Authorization completed.');
  }
}
