// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemPropertyResponse _$SceneItemPropertyResponseFromJson(
        Map<String, dynamic> json) =>
    SceneItemPropertyResponse(
      messageId: json['message-id'] as String,
      sceneItemProperties: (json['sceneItemProperties'] as List<dynamic>)
          .map((e) => SceneItemProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneItemPropertyResponseToJson(
        SceneItemPropertyResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'sceneItemProperties': instance.sceneItemProperties,
    };
