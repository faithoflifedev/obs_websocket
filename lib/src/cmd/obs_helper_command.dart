import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';

abstract class ObsHelperCommand extends Command {
  ObsWebSocket? _obs;

  ObsWebSocket get obs => _obs!;

  Future<void> initializeObs() async {
    final _config = <String, dynamic>{};

    if (globalResults?['uri'] == null) {
      final _configFile = File('${ObsUtil.userHome}/.obs/credentials.json');

      if (!_configFile.existsSync()) {
        throw UsageException('OBS connection information not provided.', usage);
      }

      _config.addAll(json.decode(_configFile.readAsStringSync()));
    } else {
      _config['uri'] = globalResults!['uri'];

      if (globalResults?['passwd'] == null) {
        _config['password'] = globalResults!['passwd'];
      }
    }

    _obs = await ObsWebSocket.connect(
      connectUrl: _config['uri']!,
      timeout: const Duration(seconds: 5),
    );

    final authRequired = await obs.getAuthRequired();

    if (!authRequired.status) {
      throw Exception('Could not determine authentication requirements');
    }

    if (authRequired.status && _config['password'] != null) {
      await obs.authenticate(authRequired, _config['password']!);
    } else {
      throw UsageException(
          'OBS authentication has been enabled. A password is required for a successful connection, use --help for more options',
          usage);
    }
  }
}
