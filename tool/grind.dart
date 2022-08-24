// import 'dart:convert';

import 'package:cli_pkg/cli_pkg.dart' as pkg;
import 'package:grinder/grinder.dart';
import 'package:http/http.dart' as http;
import 'package:mustache_template/mustache.dart';
import 'package:obs_websocket/src/model/util/project_config.dart';
import 'package:obs_websocket/src/util/meta_update.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec/pubspec.dart';
import 'package:universal_io/io.dart';

late final PubSpec pubSpec;

final projectConfig = ProjectConfig.fromYamlFile('tool/config.yaml');

final pubspecDirectory = Directory.current;

final newTag = isNewTag(projectConfig.version);

final client = http.Client();

main(args) async {
  pkg.githubBearerToken.value = projectConfig.pkg.githubBearerToken;
  pkg.humanName.value = projectConfig.pkg.humanName;
  pkg.botName.value = projectConfig.pkg.botName;
  pkg.botEmail.value = projectConfig.pkg.botEmail;
  pkg.executables.value = projectConfig.pkg.executables;
  // pkg.chocolateyNuspec.value = _nuspec;
  pkg.homebrewRepo.value = projectConfig.pkg.homebrewRepo;
  // pkg.homebrewFormula.value = projectConfig.pkg.homebrewFormula;
  pkg.githubReleaseNotes.value = projectConfig.change;
  pkg.homebrewTag.value = 'v${projectConfig.version}';

  pkg.addGithubTasks();
  // pkg.addHomebrewTasks();
  pkg.addNpmTasks();
  pkg.addPubTasks();

  pubSpec = await PubSpec.load(pubspecDirectory);

  grind(args);
}

@DefaultTask('Just running the tests for now.')
@Depends('homebrew')
build() {
  // log('building...');
}

@Task('Remove previously created release and build files.')
clean() {
  shell(
    exec: 'gh',
    args: ['release', 'delete', projectConfig.version, '-y'],
  );
}

@Task('All steps except for actually publishing the project.')
@Depends(analyze, version, doc, commit, 'pkg-github-release', dryrun)
// @Depends(analyze, version, test, doc, commit, release, dryrun)
publish() {
  log('''
Use the command:
  dart pub publish

To publish this package on the pub.dev site.
''');
}

@Task('Same as \'dart pub publish --dry-run\'')
dryrun() async {
  shell(args: ['pub', 'publish', '--dry-run']);
}

@Task('Generate the API documentation.')
@Depends(version)
doc() {
  DartDoc.doc();
}

@Task('analyze')
analyze() {
  Analyzer.analyze('.', fatalWarnings: true);
}

@Task(
    'Update the meta information to display "version" info int the cli command.')
meta() async {
  if (newTag) {
    MetaUpdate('pubspec.yaml').writeMetaDartFile(projectConfig.meta);

    log('version meta data file updated');
  }
}

@Task('version')
@Depends(meta)
version() async {
  if (newTag) {
    updateMarkdown();

    await updatePubspec(projectConfig.version);

    log('version meta data file updated');
  }
}

@Task('release')
release() async {
  // var response = await client.post(
  //     Uri.parse('https://api.github.com/repos/${pubSpec.homepage}/releases'),
  //     headers: {
  //       "content-type": "application/json",
  //       "authorization": 'token ${projectConfig.pkg.githubBearerToken}'
  //     },
  //     body: json.encode({
  //       "tag_name": version.toString(),
  //       "name": "$projectConfig.pkg.humanName $version",
  //       "prerelease": false,
  //       if (githubReleaseNotes.value != null) "body": githubReleaseNotes.value
  //     }));
}

@Task('homebrew')
homebrew() {
  final folder = projectConfig.pkg.homebrewRepo.split('/').last;

  try {
    File('build/$folder').deleteSync(recursive: true);
  } on FileSystemException catch (exception) {
    log(exception.message);
  }

  shell(
    exec: 'git',
    args: ['clone', 'https://github.com/${projectConfig.pkg.homebrewRepo}.git'],
    workingDirectory: 'build',
  );

  shell(
    exec: 'bash',
    args: ['commit.sh'],
    workingDirectory: 'build/$folder',
    verbose: true,
  );
}

@Task('commit')
commit() async {
  try {
    shell(
      exec: 'git',
      args: ['commit', '-a', '-m', '\'$projectConfig.commit\''],
      verbose: true,
    );
  } catch (exception) {
    log('No files committed');
  }

  if (newTag) {
    shell(exec: 'git', args: ['tag', 'v${projectConfig.version}']);

    shell(exec: 'git', args: ['push', '--tags']);
  }

  shell(
    exec: 'git',
    args: ['push'],
    verbose: true,
  );
}

@Task('test')
@Depends(meta)
test() {
  TestRunner().test();
}

bool isNewTag(String version) {
  final result = shell(
    exec: 'git',
    args: ['tag', '-l', 'v$version'],
    verbose: false,
  );

  return result.stdout.trim() != 'v$version';
}

ProcessResult shell(
    {String exec = 'dart',
    List<String> args = const <String>[],
    bool verbose = true,
    String? workingDirectory}) {
  final result = Process.runSync(
    exec,
    args,
    workingDirectory: workingDirectory,
  );

  if (verbose) {
    log('stderr:\n${result.stderr}');

    log('stdout:\n${result.stdout}');
  }

  return result;
}

void updateMarkdown() {
  final templates = projectConfig.templates;

  for (var tmpl in templates) {
    final mustacheTpl = File('tool/${tmpl.name}');

    final outputFile = File(tmpl.name);

    final template = Template(mustacheTpl.readAsStringSync(), name: tmpl.name)
        .renderString(projectConfig.toJson());

    switch (tmpl.type) {
      case 'prepend':
        final currentContent =
            outputFile.readAsStringSync().replaceFirst('# Changelog\n', '');

        if (!currentContent
            .startsWith(template.replaceFirst('# Changelog\n', ''))) {
          outputFile.writeAsStringSync(template, mode: FileMode.write);

          outputFile.writeAsStringSync(currentContent, mode: FileMode.append);
        }

        break;

      case 'overwrite':
        outputFile.deleteSync();

        outputFile.writeAsStringSync(template);

        break;

      default:
        outputFile.writeAsString(template, mode: FileMode.append);
    }
  }
}

Future<void> updatePubspec(String version) async {
  final newPubSpec = pubSpec.copy(version: Version.parse(version));

  await newPubSpec.save(pubspecDirectory);

  Pub.upgrade();
}
