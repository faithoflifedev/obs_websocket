// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamStatusResponse _$StreamStatusResponseFromJson(
        Map<String, dynamic> json) =>
    StreamStatusResponse(
      json['message-id'] as String,
      json['preview-only'] as bool,
      json['recording'] as bool,
      json['recording-paused'] as bool,
      json['status'] as String,
      json['streaming'] as bool,
    );

Map<String, dynamic> _$StreamStatusResponseToJson(
        StreamStatusResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'preview-only': instance.previewOnly,
      'recording': instance.recording,
      'recording-paused': instance.recordingPaused,
      'status': instance.status,
      'streaming': instance.streaming,
    };
