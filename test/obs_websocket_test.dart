import 'dart:convert';

import 'package:obs_websocket/obs_websocket.dart';
import 'package:test/test.dart';

void main() {
  test('GetStreamStatus', () async {
    expect(true, true);
    final response = json.decode(
        '{"d":{"requestId":"80cf6055-23be-4241-982f-b75ef6194047","requestStatus":{"code":100,"result":true},"requestType":"GetStreamStatus","responseData":{"outputActive":false,"outputBytes":0,"outputCongestion":0.0,"outputDuration":0,"outputReconnecting":false,"outputSkippedFrames":0,"outputTimecode":"00:00:00.000","outputTotalFrames":0}},"op":7}');

    final opcode = Opcode.fromJson(response);

    final requestResponse = RequestResponse.fromJson(opcode.d);

    final streamStatusResponse =
        StreamStatusResponse.fromJson(requestResponse.responseData!);

    expect(opcode.op, 7);
    expect(requestResponse.requestType, 'GetStreamStatus');
    expect(requestResponse.requestStatus.code, 100);
    expect(streamStatusResponse.runtimeType, StreamStatusResponse);
  });

  test('GetStats', () async {
    expect(true, true);
    final response = json.decode(
        '{"d":{"requestId":"5c536f30-f800-4b72-bf05-d88f003c4697","requestStatus":{"code":100,"result":true},"requestType":"GetStats","responseData":{"activeFps":23.976024167640556,"availableDiskSpace":19014.4609375,"averageFrameRenderTime":0.495866,"cpuUsage":-0.027235297172177826,"memoryUsage":495.81640625,"outputSkippedFrames":0,"outputTotalFrames":1324,"renderSkippedFrames":1351,"renderTotalFrames":5383930,"webSocketSessionIncomingMessages":4,"webSocketSessionOutgoingMessages":4}},"op":7}');

    final opcode = Opcode.fromJson(response);

    final requestResponse = RequestResponse.fromJson(opcode.d);

    final statsResponse = StatsResponse.fromJson(requestResponse.responseData!);

    expect(opcode.op, 7);
    expect(requestResponse.requestType, 'GetStats');
    expect(requestResponse.requestStatus.code, 100);
    expect(statsResponse.runtimeType, StatsResponse);
  });
}
