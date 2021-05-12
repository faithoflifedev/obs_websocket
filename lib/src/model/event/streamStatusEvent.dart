import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'streamStatusEvent.g.dart';

@JsonSerializable()
class StreamStatusEvent {
  @JsonKey(name: 'average-frame-time')
  final double? avgFrameTime;

  @JsonKey(name: 'bytes-per-sec')
  final int? bytesPerSec;

  @JsonKey(name: 'cpu-usage')
  final double? cpuUsage;

  @JsonKey(name: 'fps')
  final double? fps;

  @JsonKey(name: 'free-disk-space')
  final double? freeDiskSpace;

  @JsonKey(name: 'kbits-per-sec')
  final int? kbitsPerSec;

  @JsonKey(name: 'memory-usage')
  final double? memoryUsage;

  @JsonKey(name: 'num-dropped-frames')
  final int? numDroppedFrames;

  @JsonKey(name: 'num-total-frames')
  final int? numTotalFrames;

  @JsonKey(name: 'output-skipped-frames')
  final int? outputSkippedFrames;

  @JsonKey(name: 'output-total-frames')
  final int? outputTotalFrames;

  @JsonKey(name: 'preview-only')
  final bool? previewOnly;

  @JsonKey(name: 'recording')
  final bool? recording;

  @JsonKey(name: 'recording-paused')
  final bool? recordingPaused;

  @JsonKey(name: 'render-missed-frames')
  final int? renderMissedFrames;

  @JsonKey(name: 'render-total-frames')
  final int? renderTotalFrames;

  @JsonKey(name: 'replay-buffer-active')
  final bool? replayBufferActive;

  @JsonKey(name: 'strain')
  final double? strain;

  @JsonKey(name: 'stream-timecode')
  final String? streamTimeCode;

  @JsonKey(name: 'streaming')
  final bool? streaming;

  @JsonKey(name: 'total-stream-time')
  final int? totalStreamTime;

  @JsonKey(name: 'update-type')
  final String updateType;

  StreamStatusEvent(
      {this.avgFrameTime,
      this.bytesPerSec,
      this.cpuUsage,
      this.fps,
      this.freeDiskSpace,
      this.kbitsPerSec,
      this.memoryUsage,
      this.numDroppedFrames,
      this.numTotalFrames,
      this.outputSkippedFrames,
      this.outputTotalFrames,
      this.previewOnly,
      this.recording,
      this.recordingPaused,
      this.renderMissedFrames,
      this.renderTotalFrames,
      this.replayBufferActive,
      this.strain,
      this.streamTimeCode,
      this.streaming,
      this.totalStreamTime,
      required this.updateType});

  factory StreamStatusEvent.fromJson(Map<String, dynamic> json) =>
      _$StreamStatusEventFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStatusEventToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
