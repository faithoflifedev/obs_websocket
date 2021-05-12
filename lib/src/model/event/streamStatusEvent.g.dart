// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamStatusEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamStatusEvent _$StreamStatusEventFromJson(Map<String, dynamic> json) {
  return StreamStatusEvent(
    avgFrameTime: (json['average-frame-time'] as num?)?.toDouble(),
    bytesPerSec: json['bytes-per-sec'] as int?,
    cpuUsage: (json['cpu-usage'] as num?)?.toDouble(),
    fps: (json['fps'] as num?)?.toDouble(),
    freeDiskSpace: (json['free-disk-space'] as num?)?.toDouble(),
    kbitsPerSec: json['kbits-per-sec'] as int?,
    memoryUsage: (json['memory-usage'] as num?)?.toDouble(),
    numDroppedFrames: json['num-dropped-frames'] as int?,
    numTotalFrames: json['num-total-frames'] as int?,
    outputSkippedFrames: json['output-skipped-frames'] as int?,
    outputTotalFrames: json['output-total-frames'] as int?,
    previewOnly: json['preview-only'] as bool?,
    recording: json['recording'] as bool?,
    recordingPaused: json['recording-paused'] as bool?,
    renderMissedFrames: json['render-missed-frames'] as int?,
    renderTotalFrames: json['render-total-frames'] as int?,
    replayBufferActive: json['replay-buffer-active'] as bool?,
    strain: (json['strain'] as num?)?.toDouble(),
    streamTimeCode: json['stream-timecode'] as String?,
    streaming: json['streaming'] as bool?,
    totalStreamTime: json['total-stream-time'] as int?,
    updateType: json['update-type'] as String,
  );
}

Map<String, dynamic> _$StreamStatusEventToJson(StreamStatusEvent instance) =>
    <String, dynamic>{
      'average-frame-time': instance.avgFrameTime,
      'bytes-per-sec': instance.bytesPerSec,
      'cpu-usage': instance.cpuUsage,
      'fps': instance.fps,
      'free-disk-space': instance.freeDiskSpace,
      'kbits-per-sec': instance.kbitsPerSec,
      'memory-usage': instance.memoryUsage,
      'num-dropped-frames': instance.numDroppedFrames,
      'num-total-frames': instance.numTotalFrames,
      'output-skipped-frames': instance.outputSkippedFrames,
      'output-total-frames': instance.outputTotalFrames,
      'preview-only': instance.previewOnly,
      'recording': instance.recording,
      'recording-paused': instance.recordingPaused,
      'render-missed-frames': instance.renderMissedFrames,
      'render-total-frames': instance.renderTotalFrames,
      'replay-buffer-active': instance.replayBufferActive,
      'strain': instance.strain,
      'stream-timecode': instance.streamTimeCode,
      'streaming': instance.streaming,
      'total-stream-time': instance.totalStreamTime,
      'update-type': instance.updateType,
    };
