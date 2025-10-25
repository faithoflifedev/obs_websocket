// import 'package:loggy/loggy.dart';
import 'package:obs_websocket/event.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) async {
  final config = loadYaml(File('config.yaml').readAsStringSync());

  final obs = await ObsWebSocket.connect(
    config['host'],
    password: config['password'],
    // logOptions: LogOptions(LogLevel.debug),
    // fallbackEventHandler: (Event event) =>
    //     print('type: ${event.eventType} data: ${event.eventData}'),
    onDone: () => print('done'),
  );

  await obs
      .subscribe(EventSubscription.all | EventSubscription.inputVolumeMeters);

  obs.addHandler<SceneNameChanged>((sceneNameChanged) async =>
      print('scene name changed: \n$sceneNameChanged'));

  obs.addHandler<SceneListChanged>((sceneListChanged) async =>
      print('scene list changed: \n$sceneListChanged'));

  obs.addHandler<InputAudioBalanceChanged>((inputAudioBalanceChanged) async =>
      print('''input audio balance changed: \n
    inputAudioBalance - ${inputAudioBalanceChanged.inputAudioBalance}
    '''));

  obs.addHandler<InputVolumeMeters>(
      (inputVolumeMeters) async => print(inputVolumeMeters));

  obs.addHandler<ExitStarted>((exitStarted) async {
    print('exit started: \n$exitStarted');

    obs.close();

    exit(0);
  });
}
