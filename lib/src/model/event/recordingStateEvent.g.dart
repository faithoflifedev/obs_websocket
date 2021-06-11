// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordingStateEvent.dart';

// **************************************************************************
// EasyEnumGenerator
// **************************************************************************

extension RecordingStateExt on RecordingState {
  String get value => [
        'recordingStarting',
        'recordingStarted',
        'recordingStopping',
        'recordingStopped',
        'recordingPaused',
        'recordingResumed'
      ][index];
}

extension RecordingStateTxe on String {
  RecordingState? get recordingState => {
        'recordingStarting': RecordingState.recordingStarting,
        'recordingStarted': RecordingState.recordingStarted,
        'recordingStopping': RecordingState.recordingStopping,
        'recordingStopped': RecordingState.recordingStopped,
        'recordingPaused': RecordingState.recordingPaused,
        'recordingResumed': RecordingState.recordingResumed,
      }[this];
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingStateEvent _$RecordingStateEventFromJson(Map<String, dynamic> json) {
  return RecordingStateEvent(
    recordingFilename: json['recordingFilename'] as String?,
    type: _$enumDecodeNullable(_$RecordingStateEnumMap, json['type']),
  );
}

Map<String, dynamic> _$RecordingStateEventToJson(
        RecordingStateEvent instance) =>
    <String, dynamic>{
      'recordingFilename': instance.recordingFilename,
      'type': _$RecordingStateEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$RecordingStateEnumMap = {
  RecordingState.recordingStarting: 'recordingStarting',
  RecordingState.recordingStarted: 'recordingStarted',
  RecordingState.recordingStopping: 'recordingStopping',
  RecordingState.recordingStopped: 'recordingStopped',
  RecordingState.recordingPaused: 'recordingPaused',
  RecordingState.recordingResumed: 'recordingResumed',
};
