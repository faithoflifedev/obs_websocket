// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_created.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemCreated _$SceneItemCreatedFromJson(Map<String, dynamic> json) =>
    SceneItemCreated(
      sceneName: json['sceneName'] as String,
      sourceName: json['sourceName'] as String,
      sceneItemId: json['sceneItemId'] as int,
      sceneItemIndex: json['sceneItemIndex'] as int,
    );

Map<String, dynamic> _$SceneItemCreatedToJson(SceneItemCreated instance) =>
    <String, dynamic>{
      'sceneName': instance.sceneName,
      'sourceName': instance.sourceName,
      'sceneItemId': instance.sceneItemId,
      'sceneItemIndex': instance.sceneItemIndex,
    };
