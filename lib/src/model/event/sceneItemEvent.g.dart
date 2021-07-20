// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneItemEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemEvent _$SceneItemEventFromJson(Map<String, dynamic> json) =>
    SceneItemEvent(
      itemId: json['item-id'] as int,
      itemName: json['item-name'] as String,
      sceneName: json['scene-name'] as String,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SceneItemEventToJson(SceneItemEvent instance) =>
    <String, dynamic>{
      'item-id': instance.itemId,
      'item-name': instance.itemName,
      'scene-name': instance.sceneName,
      'type': instance.type,
    };
