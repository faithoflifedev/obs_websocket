# easy_obs_websocket

Some background first. I needed a way to automate the start and stop streaming actions for [OBS](https://obsproject.com/) (Open Broadcast Software) with [cron](https://en.wikipedia.org/wiki/Cron) on OSX. This package will allow you to do that with [dart](https://dart.dev/) or can be used with [flutter](https://flutter.dev/) to control OBS with a platform independent mobile app.

This package gives access to all of the methods and events outlined by the [obs-websocket 4.9.1 protocol reference](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) through the `command` method documented below, but also has helper methods for many of the more popular [Requests](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#requests) that are made available through the protocol reference.

[![pub package](https://img.shields.io/pub/v/obs_websocket.svg)](https://pub.dartlang.org/packages/obs_websocket)

Please feel free to submit PRs for any addtional helper methods, or report an [issue](https://github.com/faithoflifedev/obsWebsocket/issues) for a missing helper method and I'll add it if I have time available.

## Getting Started

### Requirements:

- The [OBS](https://obsproject.com/) application needs to be installed on a machine reachable on the local network
- The [obs-websocket](https://github.com/Palakis/obs-websocket) plugin needs to be installed on the same machine

In your project add the dependency:

```yml
dependencies:
  ...
  obs_websocket: ^2.2.10
```

For help getting started with dart, check out these [guides](https://dart.dev/guides).

## Usage Example

Import the websocket connection library and the response library.

```dart
import 'package:obs_websocket/obs_websocket.dart';
```

## Opening a websocket Connection

The WebSocket protocol, described in the specification [RFC 6455](https://tools.ietf.org/html/rfc6455) provides a way to exchange data between client and server via a persistent connection. The data can be passed in both directions as “packets”.

Before a websocket connection can be made to a running instance of [OBS](https://obsproject.com/), you will need to have the [obs-websocket](https://obsproject.com/forum/resources/obs-websocket-remote-control-obs-studio-from-websockets.466/) plugin installed and configured.

To open a websocket connection, we need to create new ObsWebSocket using the special protocol ws in the url:

```dart
//the method to connect has changed with v2.1.x
ObsWebSocket obsWebSocket =
    await ObsWebSocket.connect(connectUrl: 'ws://[obs-studio host ip]:4444');

```

obs-studio host ip - is the ip address or host name of the computer running [OBS](https://obsproject.com/) that wou would like to send remote control commands to.

## Authenticating to [OBS](https://obsproject.com/)

[OBS](https://obsproject.com/) has an optional, but highly recommended password security feature, the `getAuthRequired` method will check if the password security has been enabled. The `AuthRequired` object that the method call returns is used as part of the authentication process. The [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) documentation provided on the [obs-websocket](https://github.com/Palakis/obs-websocket) github pages covers this in detail.

```dart
final AuthRequired authRequired = await obsWebSocket.getAuthRequired();

if (authRequired.status)
	await obsWebSocket.authenticate(authRequired, '[password]');
```

## Sending Commands to [OBS](https://obsproject.com/)

The available commands are documented on the [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) page of the [obs-websocket](https://github.com/Palakis/obs-websocket) github page. Note that not all commands listed on the protocol page have been implemented in code at this time. For any command not yet implemented, refer to the "low-level" method of sending commands, documented below.

```dart
final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

if (!status.streaming) {
  await obsWebSocket.startStreaming();
}
```

## Sending Commands to [OBS](https://obsproject.com/) - low level

Alternatively, there is a low-level interface for sending commands. This can be used in place of the above, or in the case that a specific documented Request has not been implemented as method yet. The available commands are documented on the [protocol](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md) page of the [obs-websocket](https://github.com/Palakis/obs-websocket) github page

```dart
SimpleResponse response await obsWebSocket.command('StartStreaming');
```

`response.status` will be `true` on success. `response.error` will give an error description if one is available.

Commands can also return a result as a `Map`:

```dart
SimpleResponse response = await obsWebSocket.command('GetSourcesList');

List sources = response.map['sources'];

sources.forEach((source) => print(source['name'] + ' - ' + source['type']));
```

Additionally you can provide arguments with a command:

```dart
response = await obsWebSocket.command('GetSourceSettings', { 'sourceName': 'foreground' });

Map newSettings = Map<String,dynamic>.from(response.map);

newSettings['sourceSettings']['height'] = 1080;
newSettings['sourceSettings']['width'] = 1920;

response = await obsWebSocket.command('SetSourceSettings', newSettings);

print(response.map);
```

## Events - v2.1.0 intruduced a new model for event handling

Events generated by OBS through the websocket can be hooked into by supplying an event listener in the form of `addHandler<T>(Function handler)`. In the sample code below a hook is created that waits for a `SceneItemStateEvent` event. If the type of event is `SceneItemState.SceneItemVisibilityChanged`, and if the `SceneItem` is visbile the code hides the `SceneItem` after 13 seconds. This code from the `showSceneitem.dart` example could be used in a cron job to show and then hide an OBS `SceneItem` periodically.

```dart
//sceneItem for this event
final sceneItem = 'ytBell';

ObsWebSocket obsWebSocket = ObsWebSocket(
    connectUrl: 'ws://[obs-studio host ip]:4444');

//this handler will only run when a SceneItemState event is generated
obsWebSocket
    .addHandler<SceneItemStateEvent>((SceneItemStateEvent sceneItemStateEvent) async {
    //make sure we have the correct sceneItem and that it's currently visible
    if (sceneItemStateEvent.type == 'SceneItemVisibilityChanged' &&
        sceneItemStateEvent.itemName == sceneItem &&
        sceneItemStateEvent.state) {
      //wait 13 seconds
      await Future.delayed(Duration(seconds: 13));

      //hide the sceneItem
      await obsWebSocket
          .setSceneItemRender(sceneItemStateEvent.toSceneItemRenderMap(false));

      //close the socket when complete
      await obsWebSocket.close();
    }
  }
});
```

## Supported Events for `addHandler<T>`

| class                                                                                                                  | types                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [RecordingStateEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/RecordingStateEvent-class.html) | [RecordingStarting](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingstarting), [RecordingStarted](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingstarted), [RecordingStopping](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingstopping), [RecordingStopped](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingstopped), [RecordingPausedEvent](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingpaused), [RecordingResumed](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recordingresumed) |
| [SceneItemEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/SceneItemEvent-class.html)           | [SceneItemAdded](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemadded), [SceneItemRemoved](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemremoved), [SceneItemSelected](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemselected), [SceneItemDeselected](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemdeselected)                                                                                                                                                                                                                                                          |
| [SceneItemStateEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/SceneItemStateEvent-class.html) | [SceneItemVisibilityChanged](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemvisibilitychanged), [SceneItemLockChanged](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sceneitemlockchanged)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [StreamStateEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/StreamStateEvent-class.html)       | [StreamStarting](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streamstarting), [StreamStarted](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streamstarted), [StreamStopping](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streamstopping), [StreamStoppedEvent](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streamstopped)                                                                                                                                                                                                                                                                             |
| [StreamStatusEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/StreamStatusEvent-class.html)     | [StreamStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streamstatus)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| [BaseEvent](https://pub.dev/documentation/obs_websocket/latest/obs_websocket/BaseEvent-class.html)                     | any not listed above, the `Map<String, dynamic> rawEvent` property gives access to the underlying event response data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

## Closing the websocket

Finally before your code completes, you will should close the websocket connection. Failing to close the connection can lead to unexpected performance related issues for your OBS instance.

```dart
obsWebSocket.close();
```

## Sample OBS cli

This code base includes sample code for a OBS cli application that can be used to send `obs-websocket` protocol based commands to OBS. An example of a command is as follows:

```bash
dart bin/ws-obs.dart --command GetStreamingStatus --url=ws:///[obs-studio host ip]:4444  --passwd [password]
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

## Supported high-level commands

For any of the items that have an [x] from the list below, a high level command is available for that operation, i.e. `obsWebSocket.getStudioModeStatus()` otherwise a low-level command can be used to perform the operation, `obsWebSocket.command('GetVersion')`.

- [Requests](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#requests)
  - [General](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#general-1)
    - [ ] [GetVersion](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getversion)
    - [x] [GetAuthRequired](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getauthrequired)
    - [x] [Authenticate](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#authenticate)
    - [ ] [SetHeartbeat](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setheartbeat)
    - [ ] [SetFilenameFormatting](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setfilenameformatting)
    - [ ] [GetFilenameFormatting](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getfilenameformatting)
    - [ ] [GetStats](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getstats)
    - [ ] [BroadcastCustomMessage](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#broadcastcustommessage-1)
    - [ ] [GetVideoInfo](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getvideoinfo)
    - [ ] [OpenProjector](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#openprojector)
    - [ ] [TriggerHotkeyByName](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#triggerhotkeybyname)
    - [ ] [TriggerHotkeyBySequence](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#triggerhotkeybysequence)
    - [ ] [ExecuteBatch](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#executebatch)
    - [ ] [Sleep](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sleep)
  - [Media Control](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#media-control)
    - [x] [PlayPauseMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#playpausemedia)
    - [x] [RestartMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#restartmedia)
    - [x] [StopMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stopmedia)
    - [ ] [NextMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#nextmedia)
    - [ ] [PreviousMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#previousmedia)
    - [ ] [GetMediaDuration](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getmediaduration)
    - [ ] [GetMediaTime](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getmediatime)
    - [ ] [SetMediaTime](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setmediatime)
    - [ ] [ScrubMedia](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#scrubmedia)
    - [x] [GetMediaState](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getmediastate)
  - [Sources](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sources-1)
    - [x] [GetMediaSourcesList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getmediasourceslist)
    - [ ] [CreateSource](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#createsource)
    - [x] [GetSourcesList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourceslist)
    - [ ] [GetSourceTypesList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourcetypeslist)
    - [ ] [GetVolume](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getvolume)
    - [ ] [SetVolume](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setvolume)
    - [ ] [SetTracks](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settracks)
    - [ ] [GetTracks](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettracks)
    - [ ] [GetMute](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getmute)
    - [ ] [SetMute](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setmute)
    - [ ] [ToggleMute](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#togglemute)
    - [x] [GetSourceActive](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourceactive)
    - [x] [GetAudioActive](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getaudioactive)
    - [ ] [SetSourceName](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsourcename)
    - [ ] [SetSyncOffset](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsyncoffset)
    - [ ] [GetSyncOffset](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsyncoffset)
    - [ ] [GetSourceSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourcesettings)
    - [ ] [SetSourceSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsourcesettings)
    - [ ] [GetTextGDIPlusProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettextgdiplusproperties)
    - [ ] [SetTextGDIPlusProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settextgdiplusproperties)
    - [ ] [GetTextFreetype2Properties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettextfreetype2properties)
    - [ ] [SetTextFreetype2Properties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settextfreetype2properties)
    - [ ] [GetBrowserSourceProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getbrowsersourceproperties)
    - [ ] [SetBrowserSourceProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setbrowsersourceproperties)
    - [ ] [GetSpecialSources](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getspecialsources)
    - [ ] [GetSourceFilters](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourcefilters)
    - [ ] [GetSourceFilterInfo](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourcefilterinfo)
    - [ ] [AddFilterToSource](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#addfiltertosource)
    - [ ] [RemoveFilterFromSource](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#removefilterfromsource)
    - [ ] [ReorderSourceFilter](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#reordersourcefilter)
    - [ ] [MoveSourceFilter](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#movesourcefilter)
    - [ ] [SetSourceFilterSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsourcefiltersettings)
    - [ ] [SetSourceFilterVisibility](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsourcefiltervisibility)
    - [ ] [GetAudioMonitorType](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getaudiomonitortype)
    - [ ] [SetAudioMonitorType](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setaudiomonitortype)
    - [ ] [GetSourceDefaultSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsourcedefaultsettings)
    - [x] [TakeSourceScreenshot](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#takesourcescreenshot)
    - [x] [RefreshBrowserSource](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#refreshbrowsersource)
  - [Outputs](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#outputs)
    - [ ] [ListOutputs](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#listoutputs)
    - [ ] [GetOutputInfo](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getoutputinfo)
    - [ ] [StartOutput](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startoutput)
    - [ ] [StopOutput](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stopoutput)
  - [Profiles](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#profiles-1)
    - [x] [SetCurrentProfile](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setcurrentprofile)
    - [x] [GetCurrentProfile](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getcurrentprofile)
    - [ ] [ListProfiles](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#listprofiles)
  - [Recording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#recording-1)
    - [ ] [GetRecordingStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getrecordingstatus)
    - [x] [StartStopRecording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startstoprecording)
    - [x] [StartRecording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startrecording)
    - [x] [StopRecording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stoprecording)
    - [x] [PauseRecording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#pauserecording)
    - [x] [ResumeRecording](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#resumerecording)
    - [ ] [SetRecordingFolder](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setrecordingfolder)
    - [ ] [GetRecordingFolder](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getrecordingfolder)
  - [Replay Buffer](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#replay-buffer-1)
    - [ ] [GetReplayBufferStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getreplaybufferstatus)
    - [ ] [StartStopReplayBuffer](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startstopreplaybuffer)
    - [ ] [StartReplayBuffer](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startreplaybuffer)
    - [ ] [StopReplayBuffer](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stopreplaybuffer)
    - [ ] [SaveReplayBuffer](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#savereplaybuffer)
  - [Scene Collections](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#scene-collections)
    - [ ] [SetCurrentSceneCollection](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setcurrentscenecollection)
    - [ ] [GetCurrentSceneCollection](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getcurrentscenecollection)
    - [ ] [ListSceneCollections](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#listscenecollections)
  - [Scene Items](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#scene-items-1)
    - [ ] [GetSceneItemList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsceneitemlist)
    - [ ] [GetSceneItemProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getsceneitemproperties)
    - [ ] [SetSceneItemProperties](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsceneitemproperties)
    - [ ] [ResetSceneItem](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#resetsceneitem)
    - [x] [SetSceneItemRender](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsceneitemrender)
    - [ ] [SetSceneItemPosition](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsceneitemposition)
    - [ ] [SetSceneItemTransform](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsceneitemtransform)
    - [ ] [SetSceneItemCrop](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setsceneitemcrop)
    - [ ] [DeleteSceneItem](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#deletesceneitem)
    - [ ] [AddSceneItem](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#addsceneitem)
    - [ ] [DuplicateSceneItem](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#duplicatesceneitem)
  - [Scenes](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#scenes-1)
    - [x] [SetCurrentScene](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setcurrentscene)
    - [x] [GetCurrentScene](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getcurrentscene)
    - [ ] [GetSceneList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getscenelist)
    - [ ] [CreateScene](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#createscene)
    - [ ] [ReorderSceneItems](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#reordersceneitems)
    - [ ] [SetSceneTransitionOverride](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setscenetransitionoverride)
    - [ ] [RemoveSceneTransitionOverride](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#removescenetransitionoverride)
    - [ ] [GetSceneTransitionOverride](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getscenetransitionoverride)
  - [Streaming](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streaming-1)
    - [x] [GetStreamingStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getstreamingstatus)
    - [x] [StartStopStreaming](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startstopstreaming)
    - [x] [StartStreaming](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startstreaming)
    - [x] [StopStreaming](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stopstreaming)
    - [x] [SetStreamSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setstreamsettings)
    - [x] [GetStreamSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getstreamsettings)
    - [x] [SaveStreamSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#savestreamsettings)
    - [ ] [SendCaptions](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sendcaptions)
  - [Studio Mode](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#studio-mode-1)
    - [x] [GetStudioModeStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getstudiomodestatus)
    - [ ] [GetPreviewScene](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getpreviewscene)
    - [ ] [SetPreviewScene](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setpreviewscene)
    - [ ] [TransitionToProgram](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#transitiontoprogram)
    - [x] [EnableStudioMode](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#enablestudiomode)
    - [ ] [DisableStudioMode](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#disablestudiomode)
    - [ ] [ToggleStudioMode](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#togglestudiomode)
  - [Transitions](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#transitions-1)
    - [ ] [GetTransitionList](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettransitionlist)
    - [ ] [GetCurrentTransition](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getcurrenttransition)
    - [ ] [SetCurrentTransition](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#setcurrenttransition)
    - [ ] [SetTransitionDuration](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settransitionduration)
    - [ ] [GetTransitionDuration](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettransitionduration)
    - [ ] [GetTransitionPosition](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettransitionposition)
    - [ ] [GetTransitionSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#gettransitionsettings)
    - [ ] [SetTransitionSettings](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settransitionsettings)
    - [ ] [ReleaseTBar](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#releasetbar)
    - [ ] [SetTBarPosition](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#settbarposition)
  - [Virtual Cam](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#virtual-cam-1)
    - [ ] [GetVirtualCamStatus](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#getvirtualcamstatus)
    - [ ] [StartStopVirtualCam](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startstopvirtualcam)
    - [ ] [StartVirtualCam](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#startvirtualcam)
    - [ ] [StopVirtualCam](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md#stopvirtualcam)

## Breaking changes moving from v2.1.x to v2.2.x

The `dart pub publish` analyzer wanted a file name change, so here it is.

```dart
//This no longer works
//import 'package:obs_websocket/obsWebsocket.dart';

//instead use
import 'package:obs_websocket/obs_websocket.dart';
```

## Breaking changes moving from v2.0.x to v2.1.x

The underlying [web_socket_channel](https://pub.dev/packages/web_socket_channel) library defaults to a very long timeout and attempting to connect to OBS when it is not actually running will not throw an catchable exception, there is more info about this available in the project github [issue](https://github.com/dart-lang/web_socket_channel/issues/61) tracker. To resolve this [issue](https://github.com/faithoflifedev/obsWebsocket/issues/2) in obs_websocket there has been a modification to the code used to connect to OBS.

```dart
//This will no longer work
//ObsWebSocket obsWebSocket = ObsWebSocket(connectUrl: 'ws://[obs-studio host ip]:4444');
//
//alternatively you could use:
//final websocket = await WebSocket.connect(connectUrl).timeout(timeout);
//
//final obsWebSocket = ObsWebSocket(channel: IOWebSocketChannel(websocket));
//or
//The new connect method also gives the option for a timeout and will throw a catchable exception in
//the case that OBS is not running.  The default timeout is 30 seconds.
final obsWebSocket =
    await ObsWebSocket.connect(
      connectUrl: 'ws://[obs-studio host ip]:4444',
      timeout: const Duration(seconds: 5)
    );
```

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
//SimpleResponse response = await obsWebSocket.command('StartStreaming');

//It's been replaces with BaseResponse?
BaseResponse? response = await obsWebSocket.command('StartStreaming');
```

## Known bugs

~~I've submitted a [bug](https://github.com/Palakis/obs-websocket/issues/486) to the [obs-websocket](https://github.com/Palakis/obs-websocket) team for a bug that I am seeing when executing a websocket connecting program multiple times in sequence to start and stop steaming causes [OBS](https://obsproject.com/) to crash. For my use case I am able to work around this by stopping and restarting OBS itself before restarting streaming.~~
