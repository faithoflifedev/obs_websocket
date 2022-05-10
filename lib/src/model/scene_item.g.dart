// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItem _$SceneItemFromJson(Map<String, dynamic> json) => SceneItem(
      itemId: json['itemId'] as int,
      sourceKind: json['sourceKind'] as String,
      sourceName: json['sourceName'] as String,
      sourceType: json['sourceType'] as String,
    );

Map<String, dynamic> _$SceneItemToJson(SceneItem instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'sourceKind': instance.sourceKind,
      'sourceName': instance.sourceName,
      'sourceType': instance.sourceType,
    };
