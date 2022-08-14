// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordStatusResponse _$RecordStatusResponseFromJson(
        Map<String, dynamic> json) =>
    RecordStatusResponse(
      outputActive: json['outputActive'] as bool,
      ouputPaused: json['ouputPaused'] as bool,
      outputTimecode: json['outputTimecode'] as String,
      outputDuration: json['outputDuration'] as int,
      outputCongestion: (json['outputCongestion'] as num).toDouble(),
      outputBytes: json['outputBytes'] as int,
    );

Map<String, dynamic> _$RecordStatusResponseToJson(
        RecordStatusResponse instance) =>
    <String, dynamic>{
      'outputActive': instance.outputActive,
      'ouputPaused': instance.ouputPaused,
      'outputTimecode': instance.outputTimecode,
      'outputDuration': instance.outputDuration,
      'outputCongestion': instance.outputCongestion,
      'outputBytes': instance.outputBytes,
    };
