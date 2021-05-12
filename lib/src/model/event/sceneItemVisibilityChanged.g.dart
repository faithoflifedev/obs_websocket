// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneItemVisibilityChanged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemVisibilityChanged _$SceneItemVisibilityChangedFromJson(
    Map<String, dynamic> json) {
  return SceneItemVisibilityChanged(
    itemId: json['item-id'] as int,
    itemName: json['item-name'] as String,
    itemVisible: json['item-visible'] as bool,
    sceneName: json['scene-name'] as String,
  );
}

Map<String, dynamic> _$SceneItemVisibilityChangedToJson(
        SceneItemVisibilityChanged instance) =>
    <String, dynamic>{
      'item-id': instance.itemId,
      'item-name': instance.itemName,
      'item-visible': instance.itemVisible,
      'scene-name': instance.sceneName,
    };
