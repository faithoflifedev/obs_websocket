import 'dart:convert';

import 'package:obs_websocket/obs_websocket.dart';
import 'package:test/test.dart';

void main() {
  test('GetInputVolume', () async {
    final response = json.decode(
        '{"d":{"requestId":"6e0e75f1-f1e4-4044-a045-772dc7afe027","requestStatus":{"code":100,"result":true},"requestType":"GetInputVolume","responseData":{"inputVolumeDb":0.0,"inputVolumeMul":1.0}},"op":7}');

    final opcode = Opcode.fromJson(response);

    final requestResponse = RequestResponse.fromJson(opcode.d);

    final inputVolumeResponse =
        InputVolumeResponse.fromJson(requestResponse.responseData!);

    expect(opcode.op, 7);
    expect(requestResponse.requestType, 'GetInputVolume');
    expect(requestResponse.requestStatus.code, 100);
    expect(inputVolumeResponse.inputVolumeMul, 1.0);
  });
}
