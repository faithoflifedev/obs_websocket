// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordingStateEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingStateEvent _$RecordingStateEventFromJson(Map<String, dynamic> json) {
  return RecordingStateEvent(
    recordingFilename: json['recordingFilename'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$RecordingStateEventToJson(
        RecordingStateEvent instance) =>
    <String, dynamic>{
      'recordingFilename': instance.recordingFilename,
      'type': instance.type,
    };
