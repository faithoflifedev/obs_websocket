// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordStatusResponse _$RecordStatusResponseFromJson(
        Map<String, dynamic> json) =>
    RecordStatusResponse(
      outputActive: json['outputActive'] as bool,
      outputPaused: json['outputPaused'] as bool,
      outputTimecode: json['outputTimecode'] as String,
      outputDuration: json['outputDuration'] as int,
      outputBytes: json['outputBytes'] as int,
    );

Map<String, dynamic> _$RecordStatusResponseToJson(
        RecordStatusResponse instance) =>
    <String, dynamic>{
      'outputActive': instance.outputActive,
      'outputPaused': instance.outputPaused,
      'outputTimecode': instance.outputTimecode,
      'outputDuration': instance.outputDuration,
      'outputBytes': instance.outputBytes,
    };
