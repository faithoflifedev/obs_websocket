
# obs_websocket

This package gives access to all of the methods and events outlined by the [obs-websocket 5.1.0 protocol reference](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md) through the `send` method documented below, but also has helper methods for many of the more popular [requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests) that are made available through the protocol reference.

[![pub package](https://img.shields.io/pub/v/obs_websocket.svg)](https://pub.dartlang.org/packages/obs_websocket)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


- [obs\_websocket](#obs_websocket)
  - [Breaking changes from v2.4.3 (obs-websocket v4.9.1 protocol)](#breaking-changes-from-v243-obs-websocket-v491-protocol)
  - [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Usage Example](#usage-example)
    - [Opening a websocket Connection](#opening-a-websocket-connection)
    - [Authenticating to OBS](#authenticating-to-obs)
    - [Sending Commands to OBS](#sending-commands-to-obs)
  - [Supported high-level commands](#supported-high-level-commands)
    - [Supported Requests](#supported-requests)
  - [Helper methods](#helper-methods)
    - [browserEvent](#browserevent)
  - [Sending Commands to OBS - low level](#sending-commands-to-obs---low-level)
  - [Events](#events)
    - [Supported Events for `addHandler<T>`](#supported-events-for-addhandlert)
    - [Handling events not yet supported](#handling-events-not-yet-supported)
  - [Closing the websocket](#closing-the-websocket)
  - [obs\_websocket cli (OBS at the command prompt)](#obs_websocket-cli-obs-at-the-command-prompt)
  - [Interesting Projects](#interesting-projects)
  - [Contributors](#contributors)
  - [Contributing](#contributing)


[![Build Status](https://github.com/faithoflifedev/obs_websocket/workflows/Dart/badge.svg)](https://github.com/faithoflifedev/obs_websocket/actions) [![github last commit](https://shields.io/github/last-commit/faithoflifedev/obs_websocket)](https://shields.io/github/last-commit/faithoflifedev/obs_websocket) [![github build](https://img.shields.io/github/actions/workflow/status/faithoflifedev/obs_websocket/dart.yml?branch=main)](https://shields.io/github/workflow/status/faithoflifedev/obs_websocket/Dart) [![github issues](https://shields.io/github/issues/faithoflifedev/obs_websocket)](https://shields.io/github/issues/faithoflifedev/obs_websocket)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-1.svg)](https://www.buymeacoffee.com/faithoflif2)

## Breaking changes from v2.4.3 (obs-websocket v4.9.1 protocol)

The short answer is that everything has changed.  The obs-websocket [v5.1.0 protocol](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md) is very different from the older [v4.9.1 protocol](https://github.com/obsproject/obs-websocket/blob/4.x-current/docs/generated/protocol.md).  Any code written for the v4.9.1 protocol needs to be re-written for v5.x

## Getting Started

### Requirements

- The [OBS](https://obsproject.com/) v27.x or above application needs to be installed on a machine reachable on the local network
- The [obs-websocket](https://github.com/obsproject/obs-websocket) is included with OBS in current versions.

In your project add the dependency:

```yml
dependencies:
  ...
  obs_websocket: ^5.2.3
```

For help getting started with dart, check out these [guides](https://dart.dev/guides).

### Usage Example

Import the websocket connection library and the response library.

```dart
import 'package:obs_websocket/obs_websocket.dart';
```

### Opening a websocket Connection

The WebSocket protocol, described in the specification [RFC 6455](https://tools.ietf.org/html/rfc6455) provides a way to exchange data between client and server via a persistent connection. The data can be passed in both directions as “packets”.

Before a websocket connection can be made to a running instance of [OBS](https://obsproject.com/), you will need to have the [obs-websocket](https://github.com/obsproject/obs-websocket) plugin installed and configured.  The instruction and links to downloaded and install are available on the project [Release](https://github.com/obsproject/obs-websocket) page.

To open a websocket connection, we need to create new ObsWebSocket using the special protocol ws in the url:

```dart
final obsWebSocket =
    await ObsWebSocket.connect('ws://[obs-studio host ip]:[port]', password: '[password]');
```

`obs-studio host ip` - is the ip address or host name of the OBS device running obs-websocket protocol v5.0.0 that wou would like to send remote control commands to.

`port` is the port number used to connect to the OBS device running obs-websocket protocol v5.0.0

`password` - is the password configured for obs-websocket.

These settings are available to change and review through the OBS user interface by clicking `Tools, obs-websocket Settings`.

### Authenticating to [OBS](https://obsproject.com/)

If a `password` is supplied to the `connect` method, authentication will occur automatically assuming that it is enabled for OBS. 

### Sending Commands to [OBS](https://obsproject.com/)

The available commands/requests are documented on the [protocol](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests) page of the [obs-websocket](https://github.com/obsproject/obs-websocket) github page. Note that not all commands listed on the protocol page have been implemented in code at this time. For any command not yet implemented, refer to the `low-level` method of sending commands, documented below.

```dart
final status = await obs.stream.status;

// or this works too
// final status = await obs.stream.getStreamStatus();

if (!status.outputActive) {
  await obsWebSocket.stream.start();
}
```

## Supported high-level commands

For any of the items that have an [x\] from the list below, a high level helper command is available for that operation, i.e. `obsWebSocket.general.version` or `obsWebSocket.general.getVersion()`.  Otherwise a low-level command can be used to perform the operation, i.e. `obsWebSocket.send('GetVersion')`.

### Supported Requests

- [General Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#general-1-requests) - `obsWebSocket.general`
  - [x\] [GetVersion](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getversion) - Gets data about the current plugin and RPC version.
  - [x\] [GetStats](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstats) - Gets statistics about OBS, obs-websocket, and the current session.
  - [x\] [BroadcastCustomEvent](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#broadcastcustomevent) - Broadcasts a CustomEvent to all WebSocket clients. Receivers are clients which are identified and subscribed.
  - [x\] [CallVendorRequest](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#callvendorrequest) - Call a request registered to a vendor.
  - [x\] __obsBrowserEvent__ - A custom helper method that wraps `CallVendorRequest`, and can be used to send data to the obs-browser plugin.
  - [x\] [GetHotkeyList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist) - Gets an array of all hotkey names in OBS
  - [x\] [TriggerHotkeyByName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybyname) - Triggers a hotkey using its name. See GetHotkeyList
  - [x\] [TriggerHotkeyByKeySequence](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence) - Triggers a hotkey using a sequence of keys.
  - [x\] [Sleep](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sleep) - Sleeps for a time duration or number of frames. Only available in request batches with types SERIAL_REALTIME or SERIAL_FRAME.
- [Config Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#config-1-requests) - `obsWebSocket.config`
  - [x\] [GetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getpersistentdata) - Gets the value of a "slot" from the selected persistent data realm.
  - [x\] [SetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setpersistentdata) - Sets the value of a "slot" from the selected persistent data realm.
  - [x\] [GetSceneCollectionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenecollectionlist) - Gets an array of all scene collections
  - [x\] [SetCurrentSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection) - Switches to a scene collection.
  - [x\] [CreateSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection) - Creates a new scene collection, switching to it in the process.
  - [x\] [GetProfileList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofilelist) - Gets an array of all profiles
  - [x\] [SetCurrentProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprofile) - Switches to a profile.
  - [x\] [CreateProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createprofile) - Creates a new profile, switching to it in the process
  - [x\] [RemoveProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile) - Removes a profile. If the current profile is chosen, it will change to a different profile first.
  - [x\] [GetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofileparameter) - Gets a parameter from the current profile's configuration.
  - [x\] [SetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter) - Sets the value of a parameter in the current profile's configuration.
  - [x\] [GetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvideosettings) - Gets the current video settings.
  - [x\] [SetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setvideosettings) - Sets the current video settings.
  - [x\] [GetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamservicesettings) - Gets the current stream service settings (stream destination).
  - [x\] [SetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings) - Sets the current stream service settings (stream destination).
  - [x\] [GetRecordDirectory](https://github.com/obsproject/obs-websocket/blob/release/5.2.3/docs/generated/protocol.md#getrecorddirectory) - Gets the current directory that the record output is set to.
- [Sources Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sources-requests) - `obsWebSocket.sources`
  - [x\] [GetSourceActive](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourceactive) - Gets the active and show state of a source.
  - [x\] [GetSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcescreenshot) - Gets a Base64-encoded screenshot of a source.
  - [x\] [SaveSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savesourcescreenshot) - Saves a screenshot of a source to the filesystem.
- [Scenes Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenes-1-requests) - `obsWebSocket.scenes`
  - [x\] [GetSceneList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist) - Gets an array of all scenes in OBS.
  - [x\] [GetGroupList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist) - Gets an array of all groups in OBS.
  - [x\] [GetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene) - Gets the current program scene.
  - [x\] [SetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprogramscene) - Sets the current program scene.
  - [x\] [GetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene) - Gets the current preview scene (only available when studio mode is enabled).
  - [x\] [SetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentpreviewscene) - Sets the current preview scene (only available when studio mode is enabled).
  - [x\] [CreateScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene) - Creates a new scene in OBS.
  - [x\] [RemoveScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene) - Removes a scene from OBS.
  - [x\] [SetSceneName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename) - Sets the name of a scene (rename).
  - [x\] [GetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenescenetransitionoverride) - Gets the scene transition overridden for a scene.
  - [x\] [SetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride) - Sets the scene transition overridden for a scene.
- [Inputs Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputs-1-requests) - `obsWebSocket.inputs`
  - [x\] [GetInputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputlist) - Gets an array of all inputs in OBS.
  - [x\] [GetInputKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist) - Gets an array of all available input kinds in OBS.
  - [x\] [GetSpecialInputs](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getspecialinputs) - Gets the names of all special inputs.
  - [x\] [CreateInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput) - Creates a new input, adding it as a scene item to the specified scene.
  - [x\] [RemoveInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput) - Removes an existing input.
  - [x\] [SetInputName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname) - Sets the name of an input (rename).
  - [x\] [GetInputDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings) - Gets the default settings for an input kind.
  - [x\] [GetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings) - Gets the settings of an input.
  - [x\] [SetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputsettings) - Sets the settings of an input.
  - [x\] [GetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputmute) - Gets the audio mute state of an input.
  - [x\] [SetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputmute) - Sets the audio mute state of an input.
  - [x\] [ToggleInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleinputmute) - Toggles the audio mute state of an input.
  - [x\] [GetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume) - Gets the current volume setting of an input.
  - [ \] [SetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume)
  - [ \] [GetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance)
  - [ \] [SetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance)
  - [ \] [GetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiosyncoffset)
  - [ \] [SetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiosyncoffset)
  - [ \] [GetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)
  - [ \] [SetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype)
  - [ \] [GetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks)
  - [ \] [SetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiotracks)
  - [ \] [GetInputPropertiesListPropertyItems](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputpropertieslistpropertyitems)
  - [ \] [PressInputPropertiesButton](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pressinputpropertiesbutton)
- [Transitions Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#transitions-1-requests) - `obsWebSocket.transitions`
  - [ \] [GetTransitionKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gettransitionkindlist)
  - [ \] [GetSceneTransitionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist)
  - [ \] [GetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransition)
  - [x\] [SetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransition) - Sets the current scene transition.
  - [x\] [SetCurrentSceneTransitionDuration](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration) - Sets the duration of the current scene transition, if it is not fixed.
  - [ \] [SetCurrentSceneTransitionSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings)
  - [ \] [GetCurrentSceneTransitionCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor)
  - [x\] [TriggerStudioModeTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerstudiomodetransition) - Triggers the current scene transition. Same functionality as the Transition button in studio mode.
  - [ \] [SetTBarPosition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition)
- [Filters Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#filters-1-requests) - `obsWebSocket.filters`
  - [ \] [GetSourceFilterList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist)
  - [ \] [GetSourceFilterDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings)
  - [ \] [CreateSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter)
  - [x\] [RemoveSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter) - Sets the index position of a filter on a source.
  - [x\] [SetSourceFilterName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername) - Sets the name of a source filter (rename).
  - [ \] [GetSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter)
  - [x\] [SetSourceFilterIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex) - Sets the index position of a filter on a source.
  - [ \] [SetSourceFilterSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings)
  - [x\] [SetSourceFilterEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled) - Sets the enable state of a source filter.
- [Scene Items Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scene-items-1-requests) - `obsWebSocket.sceneItems`
  - [x\] [GetSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist) - Gets a list of all scene items in a scene.
  - [x\] [GetGroupSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgroupsceneitemlist) - Basically GetSceneItemList, but for groups.
  - [x\] [GetSceneItemId](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemid) - Searches a scene for a source, and returns its id.
  - [ \] [CreateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsceneitem)
  - [ \] [RemoveSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesceneitem)
  - [ \] [DuplicateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#duplicatesceneitem)
  - [ \] [GetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemtransform)
  - [ \] [SetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform)
  - [x\] [GetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled) - Gets the enable state of a scene item.
  - [x\] [SetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled) - Sets the enable state of a scene item.
  - [x\] [GetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked) - Gets the lock state of a scene item.
  - [x\] [SetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked) - Sets the lock state of a scene item.
  - [x\] [GetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex) - Gets the index position of a scene item in a scene.
  - [x\] [SetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex) - Sets the index position of a scene item in a scene.
  - [ \] [GetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemblendmode)
  - [ \] [SetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode)
- [Outputs Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#outputs-1-requests) - `obsWebSocket.outputs`
  - [x\] [GetVirtualCamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus) - Gets the status of the virtualcam output.
  - [x\] [ToggleVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglevirtualcam) - Toggles the state of the virtualcam output.
  - [x\] [StartVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam) - Starts the virtualcam output.
  - [x\] [StopVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopvirtualcam) - Stops the virtualcam output.
  - [x\] [GetReplayBufferStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getreplaybufferstatus) - Gets the status of the replay buffer output.
  - [x\] [ToggleReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglereplaybuffer) - Toggles the state of the replay buffer output.
  - [x\] [StartReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startreplaybuffer) - Starts the replay buffer output.
  - [x\] [StopReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopreplaybuffer) - Stops the replay buffer output.
  - [x\] [SaveReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer) - Saves the contents of the replay buffer output.
  - [ \] [GetLastReplayBufferReplay](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getlastreplaybufferreplay)
  - [ \] [GetOutputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist)
  - [ \] [GetOutputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputstatus)
  - [x\] [ToggleOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput) - Toggles the status of an output.
  - [x\] [StartOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput) - Starts an output.
  - [x\] [StopOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput) - Stops an output.
  - [ \] [GetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings)
  - [ \] [SetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings)
- [Stream Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stream-requests) - `obsWebSocket.stream`
  - [x\] [GetStreamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus) - Gets the status of the stream output.
  - [x\] [ToggleStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglestream) - Toggles the status of the stream output.
  - [x\] [StartStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startstream) - Starts the stream output.
  - [x\] [StopStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopstream) - Stops the stream output.
  - [x\] [SendStreamCaption](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sendstreamcaption) - Sends CEA-608 caption text over the stream output.
- [Record Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#record-requests) - `obsWebSocket.record`
  - [x\] [GetRecordStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecordstatus) - Gets the status of the record output.
  - [x\] [ToggleRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord) - Toggles the status of the record output.
  - [x\] [StartRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startrecord) - Starts the record output.
  - [x\] [StopRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stoprecord) - Stops the record output.
  - [x\] [ToggleRecordPause](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecordpause) - Toggles pause on the record output.
  - [x\] [PauseRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pauserecord) - Pauses the record output.
  - [x\] [ResumeRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#resumerecord) - Resumes the record output.
- [Media Inputs Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#media-inputs-1-requests) - `obsWebSocket.mediaInputs`
  - [ \] [GetMediaInputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmediainputstatus)
  - [x\] [SetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor) - Sets the cursor position of a media input.
  - [x\] [OffsetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#offsetmediainputcursor) - Offsets the current cursor position of a media input by the specified value.
  - [ \] [TriggerMediaInputAction](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggermediainputaction)
- [Ui Requests](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#ui-1-requests) - `obsWebSocket.ui`
  - [x\] [GetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstudiomodeenabled) - Gets whether studio is enabled.
  - [x\] [SetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled) - Enables or disables studio mode.
  - [x\] [OpenInputPropertiesDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputpropertiesdialog) - Opens the properties dialog of an input.
  - [x\] [OpenInputFiltersDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog) - Opens the filters dialog of an input.
  - [x\] [OpenInputInteractDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputinteractdialog) - Opens the interact dialog of an input.
  - [x\] [GetMonitorList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist) - Gets a list of connected monitors and information about them.
  - [x\] [OpenVideoMixProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector) - Opens a projector for a specific output video mix.
  - [x\] [OpenSourceProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#opensourceprojector) - Opens a projector for a source.

## Helper methods

### browserEvent

A custom helper method that wraps `CallVendorRequest`, and can be used to send data to the obs-browser plugin.

```dart
await obsWebSocket.general.obsBrowserEvent(
  eventName: 'obs-websocket-test-event',
  eventData: {
    'my': 'data',
    'that': 'will be displayed in an event',
  },
);
```

The `Dart` code above will send an event to the [obs-browser](https://github.com/obsproject/obs-browser) plugin.  By including the Javascript shown below in a page referenced by the plugin, that page can receive and react to events generated by `Dart` code.

```javascript
window.addEventListener('obs-websocket-test-event', function(event) {
  console.log(event); //  {"my":"data","that":"will be displayed in an event"}
});
```

## Sending Commands to [OBS](https://obsproject.com/) - low level

Alternatively, there is a low-level interface for sending commands. This can be used in place of the above, or in the case that a specific documented Request has not been implemented as a helper method yet. The available commands are documented on the [protocol](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests) page of the [obs-websocket](https://github.com/obsproject/obs-websocket) github page

```dart
var response = await obsWebSocket.send('GetStreamStatus');

print('request status: ${response?.requestStatus.code}'); // 100 - for success

print('is streaming: ${response?.responseData?['outputActive']}'); // false - if not currently streaming
```

`response?.requestStatus.result` will be `true` on success. `response?.requestStatus.code` will give a response code that is explained in the [RequestStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requeststatus) portion of the protocol documentation.

`response?.requestStatus.comment` will sometimes give additional information about errors that might be generated.

Dealing with a list in the `responseData`.

```dart
var response = await obs.send('GetSceneList');

var scenes = response?.responseData?['scenes'];

scenes.forEach(
    (scene) => print('${scene['sceneName']} - ${scene['sceneIndex']}'));
```

Additionally you can provide arguments with a command:

```dart
response = await obs.send('GetVideoSettings');

var newSettings =
    Map<String, dynamic>.from(response?.responseData as Map<String, dynamic>);

newSettings.addAll({
  'baseWidth': 1440,
  'baseHeight': 1080,
  'outputWidth': 1440,
  'outputHeight': 1080
});

// send the settings as an additional parameter.
await obs.send('SetVideoSettings', newSettings);
```

## Events

Events generated by OBS through the websocket can be hooked into by supplying an event listener in the form of `addHandler<T>(Function handler)`. In the sample code below a hook is created that waits for a `SceneItemEnableStateChanged` event. If the specified `SceneItem` is visible the code hides the `SceneItem` after 13 seconds. This code from the `show_scene_item.dart` example could be used in a cron job to show and then hide an OBS `SceneItem` periodically.

```dart
import 'package:obs_websocket/event.dart';
import 'package:obs_websocket/obs_websocket.dart';

// ...

final obsWebSocket = await ObsWebSocket.connect(config['host'], password: config['password']);

// sceneItem to show/hide
final sceneItem = 'ytBell';

// tell obsWebSocket to listen to events, since the default is to ignore them
await obsWebSocket.listen(EventSubscription.all);

// get the current scene
final currentScene = await obsWebSocket.scenes.getCurrentProgramScene();

// get the id of the required sceneItem
final sceneItemId = await obsWebSocket.sceneItems.getSceneItemId(SceneItemId(
  sceneName: currentScene,
  sourceName: sceneItem,
));

// this handler will only run when a SceneItemEnableStateChanged event is generated
obsWebSocket.addHandler<SceneItemEnableStateChanged>(
    (sceneItemEnableStateChanged) async {
  print(
      'event: ${sceneItemEnableStateChanged.sceneName} ${sceneItemEnableStateChanged.sceneItemEnabled}');

  // make sure we have the correct sceneItem and that it's currently visible
  if (sceneItemEnableStateChanged.sceneName == currentScene &&
      sceneItemEnableStateChanged.sceneItemEnabled) {
    // wait 13 seconds
    await Future.delayed(Duration(seconds: 13));

    // hide the sceneItem
    await obsWebSocket.sceneItems.setSceneItemEnabled(SceneItemEnableStateChanged(
        sceneName: currentScene,
        sceneItemId: sceneItemId,
        sceneItemEnabled: false));

    // close the socket when complete
    await obsWebSocket.close();
  }
});

// get the current state of the sceneItem
final sceneItemEnabled =
    await obsWebSocket.sceneItems.getSceneItemEnabled(SceneItemEnabled(
  sceneName: currentScene,
  sceneItemId: sceneItemId,
));

// if the sceneItem is hidden, show it
if (!sceneItemEnabled) {
  await obsWebSocket.sceneItems.setSceneItemEnabled(SceneItemEnableStateChanged(
      sceneName: currentScene,
      sceneItemId: sceneItemId,
      sceneItemEnabled: true));
}
```

### Supported Events for `addHandler<T>`

- [General Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#general-events)
  - [x\] [ExitStarted](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#exitstarted) - OBS has begun the shutdown process.
  - [x\] [VendorEvent](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#vendorevent) - An event has been emitted from a vendor.
- [Config Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#config-events)
  - [x\] [CurrentSceneCollectionChanging](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentscenecollectionchanging) - The current scene collection has begun changing.
  - [x\] [CurrentSceneCollectionChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentscenecollectionchanged) - The current scene collection has changed.
  - [x\] [SceneCollectionListChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenecollectionlistchanged) - The scene collection list has changed.
  - [x\] [CurrentProfileChanging](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentprofilechanging) - The current profile has begun changing.
  - [x\] [CurrentProfileChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentprofilechanged) - The current profile has changed.
  - [x\] [ProfileListChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#profilelistchanged) - The profile list has changed.
- [Scenes Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenes-events)
  - [x\] [SceneCreated](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenecreated) - A new scene has been created.
  - [x\] [SceneRemoved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneremoved) - A scene has been removed.
  - [x\] [SceneNameChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenenamechanged) - The name of a scene has changed.
  - [x\] [CurrentProgramSceneChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentprogramscenechanged) - The current program scene has changed.
  - [x\] [CurrentPreviewSceneChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentpreviewscenechanged) - The current preview scene has changed.
  - [x\] [SceneListChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenelistchanged) - The list of scenes has changed.
- [Inputs Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputs-events)
  - [ \] [InputCreated](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputcreated)
  - [ \] [InputRemoved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputremoved)
  - [ \] [InputNameChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputnamechanged)
  - [ \] [InputActiveStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputactivestatechanged)
  - [ \] [InputShowStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputshowstatechanged)
  - [ \] [InputMuteStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputmutestatechanged)
  - [ \] [InputVolumeChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputvolumechanged)
  - [ \] [InputAudioBalanceChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputaudiobalancechanged)
  - [ \] [InputAudioSyncOffsetChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputaudiosyncoffsetchanged)
  - [ \] [InputAudioTracksChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputaudiotrackschanged)
  - [ \] [InputAudioMonitorTypeChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputaudiomonitortypechanged)
  - [ \] [InputVolumeMeters](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#inputvolumemeters)
- [Transitions Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#transitions-events)
  - [ \] [CurrentSceneTransitionChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentscenetransitionchanged)
  - [ \] [CurrentSceneTransitionDurationChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#currentscenetransitiondurationchanged)
  - [ \] [SceneTransitionStarted](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenetransitionstarted)
  - [ \] [SceneTransitionEnded](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenetransitionended)
  - [ \] [SceneTransitionVideoEnded](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scenetransitionvideoended)
- [Filters Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#filters-events)
  - [ \] [SourceFilterListReindexed](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sourcefilterlistreindexed)
  - [ \] [SourceFilterCreated](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sourcefiltercreated)
  - [ \] [SourceFilterRemoved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sourcefilterremoved)
  - [ \] [SourceFilterNameChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sourcefilternamechanged)
  - [ \] [SourceFilterEnableStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sourcefilterenablestatechanged)
- [Scene Items Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#scene-items-events)
  - [ \] [SceneItemCreated](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemcreated)
  - [ \] [SceneItemRemoved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemremoved)
  - [ \] [SceneItemListReindexed](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemlistreindexed)
  - [x\] [SceneItemEnableStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemenablestatechanged) - A scene item's enable state has changed.
  - [ \] [SceneItemLockStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemlockstatechanged)
  - [x\] [SceneItemSelected](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemselected) - A scene item has been selected in the Ui.
  - [ \] [SceneItemTransformChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sceneitemtransformchanged)
- [Outputs Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#outputs-events)
  - [x\] [StreamStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#streamstatechanged) - The state of the stream output has changed.
  - [x\] [RecordStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#recordstatechanged) - The state of the record output has changed.
  - [ \] [ReplayBufferStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#replaybufferstatechanged)
  - [ \] [VirtualcamStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#virtualcamstatechanged)
  - [ \] [ReplayBufferSaved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#replaybuffersaved)
- [Media Inputs Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#media-inputs-events)
  - [ \] [MediaInputPlaybackStarted](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#mediainputplaybackstarted)
  - [ \] [MediaInputPlaybackEnded](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#mediainputplaybackended)
  - [ \] [MediaInputActionTriggered](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#mediainputactiontriggered)
- [Ui Events](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#ui-events)
  - [x\] [StudioModeStateChanged](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#studiomodestatechanged) - Studio mode has been enabled or disabled.
  - [x\] [ScreenshotSaved](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#screenshotsaved) - A screenshot has been saved. 
  
### Handling events not yet supported

You can supply a `fallbackEvent` to the `ObsWebSocket` constructor to handle events that are not yet supported directly in the code.  The following code snippet provides an example of this.

```dart
final obs = await ObsWebSocket.connect(
  'ws://[obs-studio host ip]:4455',
  password: '[password]',
  fallbackEventHandler: (Event event) =>
      print('type: ${event.eventType} data: ${event.eventData}'),
);

// tell obsWebSocket to listen to events, since the default is to ignore them
await obsWebSocket.listen(EventSubscription.all);
```

## Closing the websocket

Finally before your code completes, you will should close the websocket connection. Failing to close the connection can lead to unexpected performance related issues for your OBS instance.

```dart
obsWebSocket.close();
```

## obs_websocket cli (OBS at the command prompt)

A command line interface for controlling an OBS with cli commands

Please see the cli documentation [README.md](https://github.com/faithoflifedev/obs_websocket/blob/protocol_5/bin/) for more detailed usage information.

Install using `dart pub`:

```sh
dart pub global activate obs_websocket
```

Run the following command to see help:

```sh
obs --help
```

Result,

```text
A command line interface for controlling OBS.

Usage: obs <command> [arguments]

Global options:
-h, --help                        Print this usage information.
-u, --uri=<ws://[host]:[port]>    The url and port for OBS websocket
-t, --timeout=<int>               The timeout in seconds for the web socket connection.
-l, --log-level                   [all, debug, info, warning, error, off (default)]
-p, --passwd=<string>             The OBS websocket password, only required if enabled in OBS

Available commands:
  authorize     Generate an authentication file for an OBS connection
  config        Config Requests
  general       General commands
  inputs        Inputs Requests
  listen        Generate OBS events to stdout
  scene-items   Scene Items Requests
  scenes        Scenes Requests
  send          Send a low-level websocket request to OBS
  sources       Commands that manipulate OBS sources
  stream        Commands that manipulate OBS streams
  ui            Commands that manipulate the OBS user interface.
  version       Display the package name and version
```

## Interesting Projects

[Using Flutter as a source in OBS](https://www.aloisdeniel.com/blog/using-flutter-as-a-source-in-obs?source=post_page-----1b1d9bf0106e--------------------------------) - a blog post by Aloïs Deniel where he shows how to use a Fluttter application as a custom source in OBS on macOS.  He uses it to create animated scenes on his live streams on Twitch: a custom Flutter widget is used for each scene and is kept in sync with OBS thanks to the OBS websocket protocol.


## Contributors

- <img src="https://avatars.githubusercontent.com/u/923202?v=4" width="25" height="25"> [faithoflifedev](https://github.com/faithoflifedev)
  
## Contributing

Any help from the open-source community is always welcome and needed:
- Found an issue?
    - Please fill a bug report with details.
- Need a feature?
    - Open a feature request with use cases.
- Are you using and liking the project?
    - Promote the project: create an article or post about it
    - Make a donation
- Do you have a project that uses this package
    - let's cross promote, let me know and I'll add a link to your project
- Are you a developer?
    - Fix a bug and send a pull request.
    - Implement a new feature.
    - Improve the Unit Tests.
- Have you already helped in any way?
    - **Many thanks from me, the contributors and everybody that uses this project!**

*If you donate 1 hour of your time, you can contribute a lot, because others will do the same, just be part and start with your 1 hour.*