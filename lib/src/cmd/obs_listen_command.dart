import 'package:obs_websocket/command.dart';
import 'package:obs_websocket/obs_websocket.dart' show EventSubscription;

/// Listen fir OBS events
class ObsListenCommand extends ObsHelperCommand {
  @override
  String get description => 'Generate OBS events to stdout';

  @override
  String get name => 'listen';

  ObsListenCommand() {
    argParser.addOption('event-subscriptions',
        defaultsTo: 'all',
        valueHelp:
            'Supply one more more values comma separated.  See https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#eventsubscription',
        allowed: [
          'none',
          'general',
          'config',
          'scenes',
          'inputs',
          'transitions',
          'filters',
          'outputs',
          'sceneItems',
          'mediaInputs',
          'vendors',
          'ui',
          'all',
          'inputVolumeMeters',
          'inputActiveStateChanged',
          'inputShowStateChanged',
          'sceneItemTransformChanged',
        ],
        allowedHelp: {
          'none': 'Subscription value used to disable all events.',
          'general':
              'Subscription value to receive events in the General category.',
          'config':
              'Subscription value to receive events in the Config category.',
          'scenes':
              'Subscription value to receive events in the Scenes category.',
          'inputs':
              'Subscription value to receive events in the Inputs category.',
          'transitions':
              'Subscription value to receive events in the Transitions category.',
          'filters':
              'Subscription value to receive events in the Filters category.',
          'outputs':
              'Subscription value to receive events in the Outputs category.',
          'sceneItems':
              'Subscription value to receive events in the SceneItems category.',
          'mediaInputs':
              'Subscription value to receive events in the MediaInputs category.',
          'vendors': 'Subscription value to receive the VendorEvent event.',
          'ui': 'Subscription value to receive events in the Ui category.',
          'all': 'Helper to receive all non-high-volume events.',
          'inputVolumeMeters':
              'Subscription value to receive the InputVolumeMeters high-volume event.',
          'inputActiveStateChanged':
              'Subscription value to receive the InputActiveStateChanged high-volume event.',
          'inputShowStateChanged':
              'Subscription value to receive the InputShowStateChanged high-volume event.',
          'sceneItemTransformChanged':
              'Subscription value to receive the SceneItemTransformChanged high-volume event.',
        },
        help: 'Name of the source to get the active state of');
  }

  @override
  void run() async {
    await initializeObs();

    final eventSubscriptions =
        argResults!['event-subscriptions'].toString().split(',');

    final eventSubscriptionMap = EventSubscription.values.asNameMap();

    var finalSubscriptions = 0;

    for (var eventSubscription in eventSubscriptions) {
      if (eventSubscriptionMap.containsKey(eventSubscription)) {
        finalSubscriptions = eventSubscriptionMap[eventSubscription]!.code;
      }
    }

    await obs.listen(finalSubscriptions);
  }
}
