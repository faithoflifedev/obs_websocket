# obsWebsocket
Some background, I needed a way to automate the start and stop streaming actions for [OBS](https://obsproject.com/) with [cron](https://en.wikipedia.org/wiki/Cron) on OSX.  This package will aloow you to do that with [dart](https://dart.dev/) and in the future on the command line.

## Getting Started
In your flutter project add the dependency:

```yml
dependencies:
  ...
  obsWebsocket: ^0.0.1
```

For help getting started with dart, check out these [guides](https://dart.dev/guides).

## Usage Example
Import the websocket connection library and the response library.

```dart
import 'package:obsWebsocket/obsWebsocket.dart';
import 'package:obsWebsocket/response.dart';
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
The available commands are documented on the [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) page of the [obs-websocket](https://github.com/Palakis/obs-websocket) github page

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

## Closing the websocket
Finally before your code completes, you will need to close the websocket connection

```dart
obsWebSocket.close();
```

## More documentation
The [api] docs will become available when I figure out how to publish them :-)

## Known bugs
I've submitted a [bug](https://github.com/Palakis/obs-websocket/issues/486) to the [obs-websocket](https://github.com/Palakis/obs-websocket) team for a bug that I am seeing when executing a websocket connecting program multiple times in sequence, which causes [OBS](https://obsproject.com/) to crash. 