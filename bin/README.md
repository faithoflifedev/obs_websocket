# Easy OBS WebSocket CLI

A command line interface for controlling OBS with cli commands

To install:

```sh
pub global activate obs_websocket
```

Usage:

```sh
prompt>obs --help
```
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
  sources     Commands that manipulate OBS sources
  stream      Commands that manipulate OBS streaming
```

| command | description |
| --- | --- |
| authorize | Generate an authentication file for an Onvif device|
| general | General commands - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#general-requests) |
| listen | Generate OBS events to stdout - [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#events-table-of-contents) |
| sources | Commands that manipulate OBS sources, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sources-requests)|
| stream | Commands that manipulate OBS streams, [documentation](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stream-requests)|

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
#output is
false
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