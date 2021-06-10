// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItem _$SceneItemFromJson(Map<String, dynamic> json) {
  return SceneItem(
    itemId: json['item-id'] as int,
    itemName: json['item-name'] as String,
    sceneName: json['scene-name'] as String,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$SceneItemToJson(SceneItem instance) => <String, dynamic>{
      'item-id': instance.itemId,
      'item-name': instance.itemName,
      'scene-name': instance.sceneName,
      'type': instance.type,
    };
