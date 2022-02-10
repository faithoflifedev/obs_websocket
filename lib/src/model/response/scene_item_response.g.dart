// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemResponse _$SceneItemResponseFromJson(Map<String, dynamic> json) =>
    SceneItemResponse(
      messageId: json['message-id'] as String,
      sceneItems: (json['sceneItems'] as List<dynamic>)
          .map((e) => SceneItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneItemResponseToJson(SceneItemResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'sceneItems': instance.sceneItems,
    };
