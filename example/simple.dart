import 'package:loggy/loggy.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

main() async {
  Loggy.initLoggy();
  final config = loadYaml(File('config.yaml').readAsStringSync());

  ObsWebSocket obs =
      await ObsWebSocket.connect(config['host'], password: config['password']);

  await obs.listen(EventSubscription.all);

  final streamStatusResponse = await obs.stream.status();

  print('time code: ${streamStatusResponse.outputTimecode}');

  await obs.setCurrentProgramScene('presentation');

  final statsResponse = await obs.general.stats();

  print('cpu usage: ${statsResponse.cpuUsage}');

  await obs.close();
}
