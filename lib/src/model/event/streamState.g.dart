// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamState _$StreamStateFromJson(Map<String, dynamic> json) {
  return StreamState(
    previewOnly: json['preview-only'] as bool?,
  )..type = json['type'] as String?;
}

Map<String, dynamic> _$StreamStateToJson(StreamState instance) =>
    <String, dynamic>{
      'preview-only': instance.previewOnly,
      'type': instance.type,
    };
