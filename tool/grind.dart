import 'package:grinder/grinder.dart';
import 'package:publish_tools/publish_tools.dart';

main(args) async {
  PublishTools.addAllTasks();

  grind(args);
}

@DefaultTask('Just keeping it real')
@Depends('pt-commit')
build() {
  // log('building...');
}
