
# Easy OBS WebSocket CLI

A command line interface for controlling OBS with cli commands
- [Installation](#installation)
- [Quick start](#quick-start)
- [Available Commands](#available-commands)
- [authorize](#authorize)
- [config](#config)
  - [config get-stream-service-settings](#config-get-stream-service-settings)
  - [config get-video-settings](#config-get-video-settings)
  - [config set-stream-service-settings](#config-set-stream-service-settings)
  - [config set-video-settings](#config-set-video-settings)
- [general](#general)
  - [general get-stats](#general-get-stats)
  - [general get-version](#general-get-version)
- [listen](#listen)
- [send](#send)
- [sources](#sources)
  - [sources get-source-active](#sources-get-source-active)
  - [sources get-source-screenshot](#sources-get-source-screenshot)
  - [sources save-source-screenshot](#sources-save-source-screenshot)
- [stream](#stream)
  - [stream get-stream-status](#stream-get-stream-status)
  - [stream start-streaming](#stream-start-streaming)
  - [stream stop-streaming](#stream-stop-streaming)
  - [stream toggle-stream](#stream-toggle-stream)
- [ui](#ui)
  - [ui get-monitor-list](#ui-get-monitor-list)
  - [ui get-studio-mode-enabled](#ui-get-studio-mode-enabled)
  - [ui set-studio-mode-enabled](#ui-set-studio-mode-enabled)
- [version](#version)
- [Advanced Usage](#advanced-usage)
- [Subscribing to an OBS event](#subscribing-to-an-obs-event)
- [Trigger a shell command for an OBS event](#trigger-a-shell-command-for-an-obs-event)


## Installation

Install using `dart pub`:

For more information about `dart` and how to install it, check out [dart.dev](https://dart.dev/get-dart) 

```sh
dart pub global activate obs_websocket
```

Install using `brew`:

For more information about the `brew` package manager and how to install it, check out [brew.sh](https://brew.sh/) 

```sh
brew tap faithoflifedev/obs_websocket
brew install obs
```

Then check the install with,

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
  authorize   Generate an authentication file for an OBS connection
  config      Config Requests
  general     General commands
  listen      Generate OBS events to stdout
  send        Send a low-level websocket request to OBS
  sources     Commands that manipulate OBS sources
  stream      Commands that manipulate OBS streaming
  version     Display the package name version
```

| command | description |
| --- | --- |
| authorize | Generate an authentication file for an Onvif device |
| config | Config Requests - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#config-requests) |
| general | General commands - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#general-requests) |
| listen | Generate OBS events to stdout - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#events-table-of-contents) |
| send | Send a low-level websocket request to OBS - [commands](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests-table-of-contents) |
| sources | Commands that manipulate OBS sources, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sources-requests) |
| stream | Commands that manipulate OBS streams, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stream-requests) |
| version | The current package and version for this tool. |

Just like the main dart library, any responses provided through the above commands will be given in JSON format.  So ideally, you will want to use a command line json parser to interpret the results.  The recommended json parser for this purpose is [_jq_](https://stedolan.github.io/jq/).

## Quick start

```sh
# step 1
obs authorize
# follow prompts
```

```sh
# step 2
obs stream get-stream-status
```

Gives result,

```text
{"outputActive":false,"outputReconnecting":false,"outputTimecode":"00:00:00.000","outputDuration":0,"outputCongestion":0.0,"outputBytes":0,"outputSkippedFrames":0,"outputTotalFrames":0}
```

```sh
# or using the jq utility
obs stream get-stream-status | jq -r '.outputActive'
```

Result is,

```text
false
```

```sh
# or alternatively use the low-level send command
obs send --command GetStreamStatus | jq -r '.responseData.outputActive'
# same output as before: false
```

## Available Commands

### authorize

```sh
obs authorize --help
```

```text
Generate an authentication file for an OBS connection

Usage: obs authorize [arguments]
-h, --help    Print this usage information.
```

The authorize command is used to create the credentials that can be used as the default for all future commands.  In general this command will only need to be run if you want to connect to another OBS instance or if the settings (URI, password) have changed for the current connection.  The file contents are as follows:

```json
{"uri":"ws://[ip address or hostname]:[port]","password":"[password]"}
```

### config

```sh
obs config --help
```

```text
Config Requests

Usage: obs config <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-stream-service-settings   Gets the current stream service settings (stream destination).
  get-video-settings            Gets the current video settings.
  set-stream-service-settings   Sets the current stream service settings (stream destination).
  set-video-settings            Sets the current video settings.
```

#### config get-stream-service-settings

```sh
obs config get-stream-service-settings --help
```

```text
Gets the current stream service settings (stream destination).

Usage: obs config get-stream-service-settings [arguments]
```

#### config get-video-settings

```sh
obs config get-video-settings --help
```

```text
Gets the current video settings.

Usage: obs config get-video-settings [arguments]
```

#### config set-stream-service-settings

```sh
obs config set-stream-service-settings --help
```

```text
Sets the current stream service settings (stream destination).

Usage: obs config set-stream-service-settings [arguments]
-h, --help                                          Print this usage information.
    --stream-service-type=<string> (mandatory)      Type of stream service to apply. Example: rtmp_common or rtmp_custom
    --stream-service-settings=<json> (mandatory)    Settings to apply to the service
```

#### config set-video-settings

```sh
obs config set-video-settings --help
```

```text
Sets the current video settings.

Usage: obs config set-video-settings [arguments]
-h, --help                                        Print this usage information.
    --fps-numerator=<int (greater than 0)>        Numerator of the fractional FPS value
    --fps-denominator=<int (greater than 0)>      Denominator of the fractional FPS value
    --base-width=<int (between 1 and 4096)>       Width of the base (canvas) resolution in pixels
    --base-height=<int (between 1 and 4096)>      Height of the base (canvas) resolution in pixels
    --output-width=<int (between 1 and 4096)>     Width of the output resolution in pixels
    --output-height=<int (between 1 and 4096)>    Height of the output resolution in pixels
```

### general

```sh
obs general --help
```

```text
General commands

Usage: obs general <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-stats     Gets statistics about OBS, obs-websocket, and the current session.
  get-version   Gets data about the current plugin and RPC version.
```

#### general get-stats

```sh
obs general get-stats --help
```

```text
Gets statistics about OBS, obs-websocket, and the current session.

Usage: obs general get-stats [arguments]
-h, --help    Print this usage information.
```

#### general get-version

```sh
obs general get-version --help
```

```text
Gets data about the current plugin and RPC version.

Usage: obs general get-version [arguments]
-h, --help    Print this usage information.
```

### listen 

```sh
obs listen --help
```

```text
Generate OBS events to stdout

Usage: obs listen [arguments]
-h, --help      Print this usage information.
    --event-subscriptions=<Supply one more more values comma separated.
    See https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#eventsubscription>
    Name of the source to get the active state of.

          [all] (default)               Helper to receive all non-high-volume events.
          [config]                      Subscription value to receive events in the Config category.
          [filters]                     Subscription value to receive events in the Filters category.
          [general]                     Subscription value to receive events in the General category.
          [inputActiveStateChanged]     Subscription value to receive the InputActiveStateChanged high-volume event.
          [inputShowStateChanged]       Subscription value to receive the InputShowStateChanged high-volume event.
          [inputVolumeMeters]           Subscription value to receive the InputVolumeMeters high-volume event.
          [inputs]                      Subscription value to receive events in the Inputs category.
          [mediaInputs]                 Subscription value to receive events in the MediaInputs category.
          [none]                        Subscription value used to disable all events.
          [outputs]                     Subscription value to receive events in the Outputs category.
          [sceneItemTransformChanged]   Subscription value to receive the SceneItemTransformChanged high-volume event.
          [sceneItems]                  Subscription value to receive events in the SceneItems category.
          [scenes]                      Subscription value to receive events in the Scenes category.
          [transitions]                 Subscription value to receive events in the Transitions category.
          [ui]                          Subscription value to receive events in the Ui category.
          [vendors]                     Subscription value to receive the VendorEvent event.
```

### send

```sh
obs send --help
```

```text
Option command is mandatory.

Usage: obs send [arguments]
-h, --help                            Print this usage information.
-c, --command=<string> (mandatory)    One of the OBS web socket supported requests - https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests-table-of-contents
-a, --args=<json string>              The json representing the arguments necessary for the supplied command.
```

### sources

```sh
obs sources --help
```

```text
Commands that manipulate OBS sources

Usage: obs sources <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-source-active        Gets the active and show state of a source.
  get-source-screenshot    Gets a Base64-encoded screenshot of a source.
  save-source-screenshot   Saves a screenshot of a source to the filesystem.
```

#### sources get-source-active

```sh
obs sources get-source-active --help
```

```text
Gets the active and show state of a source.

Usage: obs sources get-source-active [arguments]
-h, --help                                Print this usage information.
    --source-name=<string> (mandatory)    Name of the source to get the active state of
```

#### sources get-source-screenshot

```sh
obs sources get-source-screenshot --help
```

```text
Gets a Base64-encoded screenshot of a source.

Usage: obs sources get-source-screenshot [arguments]
-h, --help                                 Print this usage information.
    --source-name=<string> (mandatory)     Name of the source to take a screenshot of
    --image-format=<string> (mandatory)    Image compression format to use. Use GetVersion to get compatible image formats
```

#### sources save-source-screenshot

```sh
obs sources save-source-screenshot --help
```

```text
Saves a screenshot of a source to the filesystem.

Usage: obs sources save-source-screenshot [arguments]
-h, --help                                    Print this usage information.
    --source-name=<string> (mandatory)        Name of the source to take a screenshot of
    --image-format=<string> (mandatory)       Image compression format to use. Use GetVersion to get compatible image formats
    --image-file-path=<string> (mandatory)    Path to save the screenshot file to.
```

### stream

```sh
obs stream --help
```

```text
Commands that manipulate OBS streams

Usage: obs stream <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-stream-status   Gets the status of the stream output.
  start-streaming     Starts the stream output.
  stop-streaming      Stops the stream output.
  toggle-stream       Toggles the status of the stream output.
```

#### stream get-stream-status

```sh
obs stream get-stream-status --help
```

```text
Gets the status of the stream output.

Usage: obs stream get-stream-status [arguments]
-h, --help    Print this usage information.
```

#### stream start-streaming

```sh
obs stream start-streaming --help
```

```text
Starts the stream output.

Usage: obs stream start-streaming [arguments]
-h, --help    Print this usage information.
``` 

#### stream stop-streaming

```sh
obs stream stop-streaming --help
```

```text
Stops the stream output.

Usage: obs stream stop-streaming [arguments]
-h, --help    Print this usage information.
```


#### stream toggle-stream

```sh
obs stream toggle-stream --help
```

```text
Toggles the status of the stream output.

Usage: obs stream toggle-stream [arguments]
-h, --help    Print this usage information.
``` 



### ui

```sh
obs ui --help
```

```text
Commands that manipulate the OBS user interface.

Usage: obs ui <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-monitor-list          Gets a list of connected monitors and information about them.
  get-studio-mode-enabled   Gets whether studio is enabled.
  set-studio-mode-enabled   Enables or disables studio mode.
```


#### ui get-monitor-list 

```sh
obs ui get-monitor-list  --help
```

```text
Gets a list of connected monitors and information about them.

Usage: obs ui get-monitor-list [arguments]
-h, --help    Print this usage information.
``` 


#### ui get-studio-mode-enabled

```sh
obs ui get-studio-mode-enabled  --help
```

```text
Gets whether studio is enabled.

Usage: obs ui get-studio-mode-enabled [arguments]
-h, --help    Print this usage information.
``` 


#### ui set-studio-mode-enabled

```sh
obs ui set-studio-mode-enabled  --help
```

```text
Enables or disables studio mode.

Usage: obs ui set-studio-mode-enabled [arguments]
-h, --help                Print this usage information.
-m, --[no-]studio-mode    
``` 


### version

```sh
obs version --help
```

```text
Display the package name and version

Usage: obs version [arguments]
-h, --help    Print this usage information.
```

## Advanced Usage

### Subscribing to an OBS event

```sh
# will output json for any "scene" related event 
obs listen --event-subscriptions scenes
```

Gives the following result,

```text
{"eventType":"CurrentProgramSceneChanged","eventIntent":4,"eventData":{"sceneName":"Scene 2"}}
{"eventType":"CurrentProgramSceneChanged","eventIntent":4,"eventData":{"sceneName":"MY Scene"}}
{"eventType":"CurrentProgramSceneChanged","eventIntent":4,"eventData":{"sceneName":"Scene 2"}}
```

Now pipe the result through the `jq` command for each event

```sh
# jq will parse the json
obs listen --event-subscriptions scenes | jq -r '.eventType + "\t" + .eventData.sceneName'
```

Gives this result,

```text
CurrentProgramSceneChanged	Scene 2
CurrentProgramSceneChanged	MY Scene
CurrentProgramSceneChanged	Scene 2
```

### Trigger a shell command for an OBS event

The `listen` command provides an optional `--command` argument that allows the user to specify the shell command that will be executed each time OBS fires one of the events that has been subscribed to.  The example below will send a separate email containing the JSON payload of each event fired.

```sh
# send an email for every scene event
obs listen --event-subscriptions scenes --command 'mutt -s "OBS Scene Event" address@email.com'
```