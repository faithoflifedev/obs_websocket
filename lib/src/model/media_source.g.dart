// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaSource _$MediaSourceFromJson(Map<String, dynamic> json) => MediaSource(
      sourceName: json['sourceName'] as String,
      sourceKind: json['sourceKind'] as String,
      mediaState: json['mediaState'] as String,
    );

Map<String, dynamic> _$MediaSourceToJson(MediaSource instance) =>
    <String, dynamic>{
      'sourceName': instance.sourceName,
      'sourceKind': instance.sourceKind,
      'mediaState': instance.mediaState,
    };
