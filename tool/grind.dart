import 'package:publish_tools/publish_tools.dart';

main(args) async {
  PublishTools.addAllTasks();

  grind(args);
}

@Task('meta')
@Depends('pt-meta')
meta() {
  log('meta done');
}

@DefaultTask('Just keeping it real')
@Depends('pt-commit', 'pt-publish', 'pt-homebrew')
done() {
  log('commit to faithoflifedev/obs_websocket complete');
  log('publish to pub.dev/packages complete.');
  log('commit to faithoflifedev/homebrew-obs_websocket complete');
}
