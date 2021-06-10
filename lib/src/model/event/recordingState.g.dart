// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordingState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingState _$RecordingStateFromJson(Map<String, dynamic> json) {
  return RecordingState(
    recordingFilename: json['recordingFilename'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$RecordingStateToJson(RecordingState instance) =>
    <String, dynamic>{
      'recordingFilename': instance.recordingFilename,
      'type': instance.type,
    };
