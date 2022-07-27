// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemId _$SceneItemIdFromJson(Map<String, dynamic> json) => SceneItemId(
      sceneName: json['sceneName'] as String,
      sourceName: json['sourceName'] as String,
      searchOffset: json['searchOffset'] as int?,
    );

Map<String, dynamic> _$SceneItemIdToJson(SceneItemId instance) =>
    <String, dynamic>{
      'sceneName': instance.sceneName,
      'sourceName': instance.sourceName,
      'searchOffset': instance.searchOffset,
    };
