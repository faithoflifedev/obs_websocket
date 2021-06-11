// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamStateEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamStateEvent _$StreamStateEventFromJson(Map<String, dynamic> json) {
  return StreamStateEvent(
    previewOnly: json['preview-only'] as bool?,
  )..type = json['type'] as String?;
}

Map<String, dynamic> _$StreamStateEventToJson(StreamStateEvent instance) =>
    <String, dynamic>{
      'preview-only': instance.previewOnly,
      'type': instance.type,
    };
