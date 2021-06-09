# obs_websocket
Some background first. I needed a way to automate the start and stop streaming actions for [OBS](https://obsproject.com/) (Open Broadcast Software) with [cron](https://en.wikipedia.org/wiki/Cron) on OSX.  This package will allow you to do that with [dart](https://dart.dev/) or can be used with [flutter](https://flutter.dev/) to control OBS with a platform independent mobile app.

This package gives access to all of the methods and events outlined by the [obs-websocket 4.9.0 protocol reference](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) through the `command` method documented below, but also has helper methods for many of the more popular [Requests](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#requests) that are made avaialble through the protocol reference.

Please feel free to submit PRs for any addtional helper methods, or report an [issue](https://github.com/faithoflifedev/obsWebsocket/issues) for a missing helper method and I'll add it if I have time available.

## Getting Started

### Requirements:
* The [OBS](https://obsproject.com/) application needs to be installed on a machine reachable on the local network
* The [obs-websocket](https://github.com/Palakis/obs-websocket) plugin needs to be installed on the same machine

In your project add the dependency:

```yml
dependencies:
  ...
  obs_websocket: ^2.0.8
```

For help getting started with dart, check out these [guides](https://dart.dev/guides).

## Usage Example
Import the websocket connection library and the response library.

```dart
import 'package:obs_websocket/obsWebsocket.dart';
```

## Opening a websocket Connection
The WebSocket protocol, described in the specification [RFC 6455](https://tools.ietf.org/html/rfc6455) provides a way to exchange data between client and server via a persistent connection. The data can be passed in both directions as “packets”.

Before a websocket connection can be made to a running instance of [OBS](https://obsproject.com/), you will need to have the [obs-websocket](https://obsproject.com/forum/resources/obs-websocket-remote-control-obs-studio-from-websockets.466/) plugin installed and configured.

To open a websocket connection, we need to create new ObsWebSocket using the special protocol ws in the url:

```dart
ObsWebSocket obsWebSocket = ObsWebSocket(connectUrl: "ws://[obs-studio host ip]:4444");
```

obs-studio host ip - is the ip address or host name of the computer running [OBS](https://obsproject.com/) that wou would like to send remote control commands to.

## Authenticating to [OBS](https://obsproject.com/)
[OBS](https://obsproject.com/) has an optional, but highly recommended password security feature, the `getAuthRequired` method will check if the password security has been enabled.  The  `AuthRequired` object that the method call returns is used as part of the authentication process.  The [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) documentation provided on the [obs-websocket](https://github.com/Palakis/obs-websocket) github pages covers this in detail.

```dart
final AuthRequired authRequired = await obsWebSocket.getAuthRequired();

if (authRequired.status)
	await obsWebSocket.authenticate(authRequired, "mySecretDontTell");
```

## Sending Commands to [OBS](https://obsproject.com/)
The available commands are documented on the [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) page of the [obs-websocket](https://github.com/Palakis/obs-websocket) github page.  Note that not all commands listed on the protocol page have been implemented in code at this time.  For any command not yet implemented, refer to the "low-level" method of sending commands, documented below.

```dart
final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

if (!status.streaming) {
  await obsWebSocket.startStreaming();
}
```

## Sending Commands to [OBS](https://obsproject.com/) - low level
Alternatively, there is a low-level interface for sending commands.  This can be used in place of the above, or in the case that a specific documented Request has not been implemented as method yet.  The available commands are documented on the [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) page of the [obs-websocket](https://github.com/Palakis/obs-websocket) github page

```dart
SimpleResponse response await obsWebSocket.command("StartStreaming");
```

`response.status` will be `true` on success. `response.error` will give an error description if one is available.

Commands can also return a result as a `Map`:

```dart
SimpleResponse response = await obsWebSocket.command("GetSourcesList");

List sources = response.map["sources"];

sources.forEach((source) => print(source["name"] + " - " + source["type"]));
```

Additionally you can provide arguments with a command:
```dart
response = await obsWebSocket.command("GetSourceSettings", { "sourceName": "foreground" });

Map newSettings = Map<String,dynamic>.from(response.map);

newSettings["sourceSettings"]["height"] = 1080;
newSettings["sourceSettings"]["width"] = 1920;

response = await obsWebSocket.command("SetSourceSettings", newSettings);

print(response.map);
```

## obs-websocket events
Events generated by OBS through the websocket can be hooked into by supplying an `onEvent` handler when creating the `ObsWebSocket`.  In the sample code below a hook is created that waits for a `SceneItemVisibilityChanged` event, then if the SceneItem is visbile the code hides it after 13 seconds.  This code from the `setIntro.dart` example could be used in a cron job to show and then hide an OBS SceneItem periodically.

```dart
ObsWebSocket obsWebSocket = ObsWebSocket(
    connectUrl: "ws://192.168.1.84:4444",
    onEvent: (BaseEvent event, ObsWebSocket obsWebSocket) async {
      // print('event: ${event.rawEvent}');

      if (event.updateType == 'SceneItemVisibilityChanged') {
        final sceneItemVisibilityChanged =
            event.asSceneItemVisibilityChangedEvent();

        if (sceneItemVisibilityChanged.itemName == sceneItem &&
            sceneItemVisibilityChanged.itemVisible) {
          final args = sceneItemVisibilityChanged.asArgs()
            ..['render'] = 'false';

          await Future.delayed(Duration(seconds: 13));

          await obsWebSocket.setSceneItemRender(args);

          await obsWebSocket.close();
        }
      }
    });
```

## Closing the websocket
Finally before your code completes, you will should close the websocket connection.  Failing to close the connection can lead to unexpected performance related issues for your OBS instance.

```dart
obsWebSocket.close();
```

## Sample OBS cli
This code base includes sample code for a OBS cli application that can be used to send `obs-websocket` protocol based commands to OBS.  An example of a command is as follows:
```bash
dart bin/ws-obs.dart --command GetStreamingStatus --url=ws://192.168.1.84:4444  --passwd myPass
```

```bash
-h, --help                        Display this helpful message
-p, --passwd                      The OBS websocket password, only required if enabled in OBS
-u, --url=<ws://[host]:[port]>    The url and port for OBS websocket
-c, --command                     Required. The OBS command to send
                                  [StartStopStreaming, StartStreaming, StopStreaming, GetStreamingStatus, GetStreamSettings, SetStreamSettings, SaveStreamSettings, GetSourcesList, GetVolume, SetVolume]
-a, --args                        Optional. The json encoded arguments for the supplied command if required
```

You can use [dart compile](https://dart.dev/tools/dart-compile) to create the cli executable.

## Breaking changes moving from v1.x to v2.x
I'm sorry to say that there are several, but it should be very easy to migrate over v1.0.0 code.

```dart
//This no longer works
//import 'package:obs_websocket/obs_websocket.dart';

//instead use
import 'package:obs_websocket/obsWebsocket.dart';

//This additional import is no longer necessary
//import 'package:obs_websocket/response.dart';

//SimpleResponse has gone away
//SimpleResponse response = await obsWebSocket.command("StartStreaming");

//It's been replaces with BaseResponse?
BaseResponse? response = await obsWebSocket.command('StartStreaming');
```

## Known bugs
~~I've submitted a [bug](https://github.com/Palakis/obs-websocket/issues/486) to the [obs-websocket](https://github.com/Palakis/obs-websocket) team for a bug that I am seeing when executing a websocket connecting program multiple times in sequence to start and stop steaming causes [OBS](https://obsproject.com/) to crash. For my use case I am able to work around this by stopping and restarting OBS itself before restarting streaming.~~


## What's next
In the next release I intent to simplify event handling somewhat.  Instead of one event handler created upon creation of the obsWebSocket instance, the library instead will provide the ability to subscribe handlers to specific events.