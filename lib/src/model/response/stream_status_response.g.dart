// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamStatusResponse _$StreamStatusResponseFromJson(
        Map<String, dynamic> json) =>
    StreamStatusResponse(
      outputActive: json['outputActive'] as bool,
      outputReconnecting: json['outputReconnecting'] as bool,
      outputTimecode: json['outputTimecode'] as String,
      outputDuration: json['outputDuration'] as int,
      outputCongestion: (json['outputCongestion'] as num).toDouble(),
      outputBytes: json['outputBytes'] as int,
      outputSkippedFrames: json['outputSkippedFrames'] as int,
      outputTotalFrames: json['outputTotalFrames'] as int,
    );

Map<String, dynamic> _$StreamStatusResponseToJson(
        StreamStatusResponse instance) =>
    <String, dynamic>{
      'outputActive': instance.outputActive,
      'outputReconnecting': instance.outputReconnecting,
      'outputTimecode': instance.outputTimecode,
      'outputDuration': instance.outputDuration,
      'outputCongestion': instance.outputCongestion,
      'outputBytes': instance.outputBytes,
      'outputSkippedFrames': instance.outputSkippedFrames,
      'outputTotalFrames': instance.outputTotalFrames,
    };
