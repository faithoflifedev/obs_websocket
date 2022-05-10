import 'package:universal_io/io.dart';

class ObsUtil {
  static String? get userHome =>
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
}
