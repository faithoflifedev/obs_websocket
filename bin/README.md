
# Easy OBS WebSocket CLI

A command line interface for controlling OBS with cli commands

- [Easy OBS WebSocket CLI](#easy-obs-websocket-cli)
  - [Quick start](#quick-start)
  - [authorize](#authorize)
  - [general](#general)
    - [general get-stats](#general-get-stats)
    - [general get-version](#general-get-version)
  - [more to come](#more-to-come)
  - [version](#version)

## Installation

Install using `dart pub`:

```sh
dart pub global activate obs_websocket
```

Install using `brew`:

```sh
brew tap faithoflifedev/obs_websocket
brew install obs
```

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
| general | General commands - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#general-requests) |
| listen | Generate OBS events to stdout - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#events-table-of-contents) |
| send | Send a low-level websocket request to OBS - [commands](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#requests-table-of-contents) |
| sources | Commands that manipulate OBS sources, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sources-requests) |
| stream | Commands that manipulate OBS streams, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stream-requests) |
| version | The current package and version for this tool. |

Just like the main library, any responses provided by the above commands will be given in the JSON format.  So ideally, you will want to use a command line json parser to interpret the results.  The recommended json parser for this purpose is [_jq_](https://stedolan.github.io/jq/).  With _jq_ you can process the results of a command as follows:

## Quick start

```sh
#step 1
obs authorize
#follow prompts

#step 2
obs stream  get-stream-status
#output would be
{"outputActive":false,"outputReconnecting":false,"outputTimecode":"00:00:00.000","outputDuration":0,"outputCongestion":0.0,"outputBytes":0,"outputSkippedFrames":0,"outputTotalFrames":0}

#or using the jq utility
obs stream  get-stream-status | jq -r '.outputActive'
#output is false

#or use the low-level send functionality
obs send --command GetStreamStatus | jq -r '.responseData.outputActive'
#same output as before: false
```

## authorize

```sh
prompt>obs authorize --help
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

## general

```sh
prompt>obs general --help
```

```text
General commands

Usage: obs general <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-stats     Gets statistics about OBS, obs-websocket, and the current session.
  get-version   Gets data about the current plugin and RPC version.
```

### general get-stats

```sh
prompt>obs general get-stats --help
```

```text
Gets statistics about OBS, obs-websocket, and the current session.

Usage: obs general get-stats [arguments]
-h, --help    Print this usage information.
```

### general get-version

```sh
prompt>obs general get-version --help
```

```text
Gets data about the current plugin and RPC version.

Usage: obs general get-version [arguments]
-h, --help    Print this usage information.
```

## more to come

...

## version

```sh
prompt>obs version --help
```

```text
Display the package name and version

Usage: obs version [arguments]
-h, --help    Print this usage information.
```