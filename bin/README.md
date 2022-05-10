# Easy OBS WebSocket CLI

A command line interface for controlling OBS with cli commands

To install:

```sh
pub global activate obs
```

Usage:

```sh
prompt>obs --help
A command line interface for controlling OBS.

Usage: obs <command> [arguments]

Global options:
-h, --help                        Print this usage information.
-u, --uri=<ws://[host]:[port]>    The url and port for OBS websocket
-p, --passwd=<string>             The OBS websocket password, only required if enabled in OBS

Available commands:
  authorize   Generate an authentication file for an Onvif device
  general     General commands.
  sources     General commands.
  streaming   Streaming commands.
```

|command|description|
|--- |--- |
|[authorize](#authorize)|Generate an authentication file for an Onvif device|
|[general](#device-management)|General commands, [documentation](https://github.com/obsproject/obs-websocket/blob/4.x-current/docs/generated/protocol.md#general-1)|
|[sources](#media)|Commands that manipulate OBS sources, [documentation](https://github.com/obsproject/obs-websocket/blob/4.x-current/docs/generated/protocol.md#sources-1)|
|[streaming](#ptz)|Commands that manipulate OBS streaming, [documentation](https://github.com/obsproject/obs-websocket/blob/4.x-current/docs/generated/protocol.md#streaming-1)|

Just like the main library, any responses provided by the above commands will be given in the JSON format.  So ideally, you will want to use a command line json parser to interpret the results.  The recommended json parser for this purpose is [_jq_](https://stedolan.github.io/jq/).  With _jq_ you can process the results of a command as follows:

## Quick start

```sh
#step 1
obs authorize
#follow prompts

#step 2
obs streaming get-stream-status
#output would be
{"message-id":"3","preview-only":false,"recording":false,"recording-paused":false,"status":"ok","streaming":true}

#or using the jq utility
obs streaming get-stream-status | jq -r '.streaming'
#output is
true
```

## authorize

```sh
prompt>obs authorize --help
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
General commands

Usage: obs general <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-auth-required   Tells the client if authentication is required. If so, returns authentication parameters challenge and salt (see "Authentication" for more information).
```

### general get-auth-required

```sh
prompt>obs general get-auth-required --help
Tells the client if authentication is required. If so, returns authentication parameters challenge and salt (see "Authentication" for more information).

Usage: obs general get-auth-required [arguments]
-h, --help    Print this usage information.
```

## sources

```sh
prompt>obs sources --help
General commands.

Usage: obs sources <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-audio-active         Get the audio's active status of a specified source.
  get-media-sources-list   List the media state of all media sources (vlc and media source)
  get-source-active        Get the source's active status of a specified source (if it is showing in the final mix).
  get-sources-list         List all sources available in the running OBS instance
  refresh-browser-source   Refreshes the specified browser source.
  take-source-screenshot   Take a snapshot from the video output
```

### sources get-audio-active

```sh
prompt>obs sources get-audio-active --help
Get the audio's active status of a specified source.

Usage: obs sources get-audio-active [arguments]
-h, --help                                Print this usage information.
    --source-name=<string> (mandatory)    Source name.
```

### sources get-media-sources-list

```sh
prompt>obs sources get-media-sources-list --help
List the media state of all media sources (vlc and media source)

Usage: obs sources get-media-sources-list [arguments]
-h, --help    Print this usage information.
```

### sources get-source-active

```sh
prompt>obs sources get-source-active --help
Get the source's active status of a specified source (if it is showing in the final mix).

Usage: obs sources get-source-active [arguments]
-h, --help                                Print this usage information.
    --source-name=<string> (mandatory)    Source name.
```

### sources get-sources-list

```sh
prompt>obs sources get-sources-list --help
List all sources available in the running OBS instance

Usage: obs sources get-sources-list [arguments]
-h, --help    Print this usage information.
```

### sources refresh-browser-source

```sh
prompt>obs sources refresh-browser-source --help
Refreshes the specified browser source.

Usage: obs sources refresh-browser-source [arguments]
-h, --help                                Print this usage information.
    --source-name=<string> (mandatory)    Source name.
```

### sources take-source-screenshot

```sh
prompt>obs sources take-source-screenshot [arguments]
-h, --help                             Print this usage information.
    --source-name=<string>             Source name. Note: Since scenes are also sources, you can also provide a scene name. If not provided, the currently active scene is used.
    --embed-picture-format=<string>    Format of the Data URI encoded picture.
                                       [png, jpg, jpeg, bmp]
    --save-to-file-path=<string>       Full file path (file extension included) where the captured image is to be saved. Can be in a format different from pictureFormat. Can be a relative path.
    --file-format=<string>             Format to save the image file as (one of the values provided in the supported-image-export-formats response field of GetVersion). If not specified, tries to guess based on file extension.
    --compression-quality=<int>        Compression ratio between -1 and 100 to write the image with. -1 is automatic, 1 is smallest file/most compression, 100 is largest file/least compression. Varies with image type.
                                       (defaults to "-1")
    --width=<int>                      Screenshot width. Defaults to the source's base width.
    --height=<int>                     Screenshot height. Defaults to the source's base height.
```

## streaming

```sh
prompt>obs streaming --help
Streaming commands.

Usage: obs streaming <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  get-stream-settings    Get the current streaming server settings.
  get-stream-status      Get current streaming and recording status.
  save-stream-settings   Save the current streaming server settings to disk.
  set-stream-settings    Sets one or more attributes of the current streaming server settings.
  start-stop-streaming   Toggle streaming on or off (depending on the current stream state).
  start-streaming        Start streaming. Will return an error if streaming is not active.
  stop-streaming         Stop streaming. Will return an error if streaming is not active.
```

### streaming get-stream-settings

```sh
prompt>obs streaming get-stream-settings --help
Get the current streaming server settings.

Usage: obs streaming get-stream-settings [arguments]
-h, --help    Print this usage information.
```

### streaming get-stream-status

```sh
prompt>obs streaming get-stream-status --help
Get current streaming and recording status.

Usage: obs streaming get-stream-status [arguments]
-h, --help    Print this usage information.
```

### streaming save-stream-settings

```sh
prompt>obs streaming save-stream-settings --help
Save the current streaming server settings to disk.

Usage: obs streaming save-stream-settings [arguments]
-h, --help    Print this usage information.
```

### streaming set-stream-settings

```sh
prompt>obs streaming set-stream-settings --help
Sets one or more attributes of the current streaming server settings.

Usage: obs streaming set-stream-settings [arguments]
-h, --help         Print this usage information.
    --type         The type of streaming service configuration, usually rtmp_custom or rtmp_common.
                   [rtmp_custom (default), rtmp_common]
    --server       The publish URL.
    --key          The publish key.
    --[no-]save    Persist the settings to disk.
```

### streaming start-stop-streaming

```sh
prompt>obs streaming start-stop-streaming --help
Toggle streaming on or off (depending on the current stream state).

Usage: obs streaming start-stop-streaming [arguments]
-h, --help    Print this usage information.
```

### streaming start-streaming

```sh
prompt>obs streaming start-streaming --help
Start streaming. Will return an error if streaming is not active.

Usage: obs streaming start-streaming [arguments]
-h, --help    Print this usage information.
```

### streaming stop-streaming

```sh
prompt>obs streaming stop-streaming --help
Stop streaming. Will return an error if streaming is not active.

Usage: obs streaming stop-streaming [arguments]
-h, --help    Print this usage information.
```
