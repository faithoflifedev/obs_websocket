import 'package:args/command_runner.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsSourcesCommand extends Command {
  @override
  String get description => 'Commands that manipulate OBS sources';

  @override
  String get name => 'sources';

  ObsSourcesCommand() {
    addSubcommand(ObsGetMediaSourcesListSourcesCommand());
    addSubcommand(ObsGetSourcesListSourcesCommand());
    addSubcommand(ObsGetSourceActiveSourcesCommand());
    addSubcommand(ObsGetAudioActiveSourcesCommand());
    addSubcommand(ObsTakeSourceScreenshotSourcesCommand());
    addSubcommand(ObsRefreshBrowserSourceSourcesCommand());
  }
}

///List the media state of all media sources (vlc and media source)
class ObsGetMediaSourcesListSourcesCommand extends ObsHelperCommand {
  @override
  String get description =>
      'List the media state of all media sources (vlc and media source)';

  @override
  String get name => 'get-media-sources-list';

  @override
  void run() async {
    await initializeObs();

    final mediaSourcesListResponse = await obs.getMediaSourcesList();

    print(mediaSourcesListResponse);

    obs.close();
  }
}

///List all sources available in the running OBS instance
class ObsGetSourcesListSourcesCommand extends ObsHelperCommand {
  @override
  String get description =>
      'List all sources available in the running OBS instance';

  @override
  String get name => 'get-sources-list';

  @override
  void run() async {
    await initializeObs();

    final sourcesListResponse = await obs.getSourcesList();

    print(sourcesListResponse);

    obs.close();
  }
}

///Get the source's active status of a specified source (if it is showing in the final mix).
class ObsGetSourceActiveSourcesCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Get the source\'s active status of a specified source (if it is showing in the final mix).';

  @override
  String get name => 'get-source-active';

  ObsGetSourceActiveSourcesCommand() {
    argParser.addOption('source-name',
        mandatory: true, valueHelp: 'string', help: 'Source name.');
  }

  @override
  void run() async {
    await initializeObs();

    final sourcesListResponse =
        await obs.getSourceActive(argResults?['source-name']);

    print(sourcesListResponse);

    obs.close();
  }
}

///Get the audio's active status of a specified source.
class ObsGetAudioActiveSourcesCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Get the audio\'s active status of a specified source.';

  @override
  String get name => 'get-audio-active';

  ObsGetAudioActiveSourcesCommand() {
    argParser.addOption('source-name',
        mandatory: true, valueHelp: 'string', help: 'Source name.');
  }

  @override
  void run() async {
    await initializeObs();

    final sourcesListResponse =
        await obs.getAudioActive(argResults?['source-name']);

    print(sourcesListResponse);

    obs.close();
  }
}

///At least embedPictureFormat or saveToFilePath must be specified.
///
///Clients can specify width and height parameters to receive scaled pictures.
///Aspect ratio is preserved if only one of these two parameters is specified.
class ObsTakeSourceScreenshotSourcesCommand extends ObsHelperCommand {
  @override
  String get description => 'Take a snapshot from the video output';

  @override
  String get name => 'take-source-screenshot';

  ObsTakeSourceScreenshotSourcesCommand() {
    argParser
      ..addOption('source-name',
          valueHelp: 'string',
          help:
              'Source name. Note: Since scenes are also sources, you can also provide a scene name. If not provided, the currently active scene is used.')
      ..addOption('embed-picture-format',
          allowed: ['png', 'jpg', 'jpeg', 'bmp'],
          valueHelp: 'string',
          help: 'Format of the Data URI encoded picture.')
      ..addOption('save-to-file-path',
          valueHelp: 'string',
          help:
              'Full file path (file extension included) where the captured image is to be saved. Can be in a format different from pictureFormat. Can be a relative path.')
      ..addOption('file-format',
          valueHelp: 'string',
          help:
              'Format to save the image file as (one of the values provided in the supported-image-export-formats response field of GetVersion). If not specified, tries to guess based on file extension.')
      ..addOption('compression-quality',
          valueHelp: 'int',
          defaultsTo: '-1',
          help:
              'Compression ratio between -1 and 100 to write the image with. -1 is automatic, 1 is smallest file/most compression, 100 is largest file/least compression. Varies with image type.')
      ..addOption('width',
          valueHelp: 'int',
          help: 'Screenshot width. Defaults to the source\'s base width.')
      ..addOption('height',
          valueHelp: 'int',
          help: 'Screenshot height. Defaults to the source\'s base height.');
  }

  @override
  void run() async {
    await initializeObs();

    if (argResults?['embed-picture-format'] == null &&
        argResults?['save-to-file-path'] == null) {
      throw UsageException(
          'At least \'embed-picture-format\' or \'save-to-file-path\' must be specified.',
          usage);
    }

    final takeSourceScreenshot = TakeSourceScreenshot(
      sourceName: argResults?['source-name'],
      embedPictureFormat: argResults?['embed-picture-format'],
      saveToFilePath: argResults?['save-to-file-path'],
      fileFormat: argResults?['file-format'],
      compressionQuality: int.parse(argResults!['compression-quality']),
      width: argResults?['width'],
      height: argResults?['height'],
    );

    final takeSourceScreenshotResponse =
        await obs.takeSourceScreenshot(takeSourceScreenshot);

    print(takeSourceScreenshotResponse);

    obs.close();
  }
}

///Refreshes the specified browser source.
class ObsRefreshBrowserSourceSourcesCommand extends ObsHelperCommand {
  @override
  String get description => 'Refreshes the specified browser source.';

  @override
  String get name => 'refresh-browser-source';

  ObsRefreshBrowserSourceSourcesCommand() {
    argParser.addOption('source-name',
        mandatory: true, valueHelp: 'string', help: 'Source name.');
  }

  @override
  void run() async {
    await initializeObs();

    await obs.refreshBrowserSource(argResults?['source-name']);

    obs.close();
  }
}
