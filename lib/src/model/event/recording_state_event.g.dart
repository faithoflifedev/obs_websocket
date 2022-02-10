// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_state_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingStateEvent _$RecordingStateEventFromJson(Map<String, dynamic> json) =>
    RecordingStateEvent(
      recordingFilename: json['recordingFilename'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$RecordingStateEventToJson(
        RecordingStateEvent instance) =>
    <String, dynamic>{
      'recordingFilename': instance.recordingFilename,
      'type': instance.type,
    };
