import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:universal_io/io.dart';

class ObsUtil {
  static String? get userHome =>
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

  ///A helper function that encrypts authentication info [data] for the purpose
  ///of authentication.
  static String base64Hash(String data) =>
      base64.encode(sha256.convert(utf8.encode(data)).bytes);
}
