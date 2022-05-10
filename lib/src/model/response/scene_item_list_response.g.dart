// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemListResponse _$SceneItemListResponseFromJson(
        Map<String, dynamic> json) =>
    SceneItemListResponse(
      messageId: json['message-id'] as String,
      sceneName: json['sceneName'] as String,
      sceneItems: (json['sceneItems'] as List<dynamic>)
          .map((e) => SceneItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneItemListResponseToJson(
        SceneItemListResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'sceneName': instance.sceneName,
      'sceneItems': instance.sceneItems,
    };
