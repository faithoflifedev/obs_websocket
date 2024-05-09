import 'package:args/command_runner.dart';
import 'package:obs_websocket/command.dart';

/// Config Requests
class ObsInputsCommand extends Command {
  @override
  String get description => 'Inputs Requests';

  @override
  String get name => 'inputs';

  ObsInputsCommand() {
    addSubcommand(ObsGetInputListCommand());
    addSubcommand(ObsGetInputKindListCommand());
    addSubcommand(ObsRemoveInputCommand());
    addSubcommand(ObsSetInputNameCommand());
    addSubcommand(ObsGetInputMuteCommand());
    addSubcommand(ObsSetInputMuteCommand());
    addSubcommand(ObsToggleInputMuteCommand());
  }
}

class ObsGetInputListCommand extends ObsHelperCommand {
  @override
  String get description => 'Gets an array of all inputs in OBS.';

  @override
  String get name => 'get-input-list';

  ObsGetInputListCommand() {
    argParser.addOption('inputKind', help: 'The kind of input to get.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputKind = argResults!['inputKind'] as String?;

    final inputs = await obs.inputs.getInputList(inputKind);

    print(inputs);

    obs.close();
  }
}

class ObsGetInputKindListCommand extends ObsHelperCommand {
  @override
  String get description =>
      'Gets an array of all available input kinds in OBS.';

  @override
  String get name => 'get-input-kind-list';

  ObsGetInputKindListCommand() {
    argParser.addFlag('unversioned',
        help: 'Whether to get unversioned input kinds.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final unversioned = argResults!['unversioned'] as bool;

    final inputKinds = await obs.inputs.getInputKindList(unversioned);

    print(inputKinds);

    obs.close();
  }
}

class ObsRemoveInputCommand extends ObsHelperCommand {
  @override
  String get description => 'Removes an existing input.';

  @override
  String get name => 'remove-input';

  ObsRemoveInputCommand() {
    argParser.addOption('inputName', help: 'The name of the input to remove.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputName = argResults!['inputName'] as String;

    await obs.inputs.removeInput(inputName);

    obs.close();
  }
}

class ObsSetInputNameCommand extends ObsHelperCommand {
  @override
  String get description => 'Sets the name of an input (rename).';

  @override
  String get name => 'set-input-name';

  ObsSetInputNameCommand() {
    argParser
      ..addOption('inputName', help: 'The name of the input to rename.')
      ..addOption('newInputName', help: 'The new name of the input.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputName = argResults!['inputName'] as String;

    final newInputName = argResults!['newInputName'] as String;

    await obs.inputs.setInputName(
      inputName: inputName,
      newInputName: newInputName,
    );

    obs.close();
  }
}

class ObsGetInputMuteCommand extends ObsHelperCommand {
  @override
  String get description => 'Gets the mute status of an input.';

  @override
  String get name => 'get-input-mute';

  ObsGetInputMuteCommand() {
    argParser.addOption('inputName',
        help: 'The name of the input to get the mute status of.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputName = argResults!['inputName'] as String;

    final muted = await obs.inputs.getInputMute(inputName);

    print(muted);

    obs.close();
  }
}

class ObsSetInputMuteCommand extends ObsHelperCommand {
  @override
  String get description => 'Sets the mute status of an input.';

  @override
  String get name => 'set-input-mute';

  ObsSetInputMuteCommand() {
    argParser.addOption('inputName',
        help: 'The name of the input to set the mute status of.');
    argParser.addFlag('mute', help: 'Whether to mute the input.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputName = argResults!['inputName'] as String;

    final inputMuted = argResults!['mute'] as bool;

    await obs.inputs.setInputMute(
      inputName: inputName,
      inputMuted: inputMuted,
    );

    obs.close();
  }
}

class ObsToggleInputMuteCommand extends ObsHelperCommand {
  @override
  String get description => 'Toggles the mute status of an input.';

  @override
  String get name => 'toggle-input-mute';

  ObsToggleInputMuteCommand() {
    argParser.addOption('inputName',
        help: 'The name of the input to toggle the mute status of.');
  }

  @override
  Future<void> run() async {
    await initializeObs();

    final inputName = argResults!['inputName'] as String;

    final muted = await obs.inputs.toggleInputMute(inputName);

    print(muted);

    obs.close();
  }
}
