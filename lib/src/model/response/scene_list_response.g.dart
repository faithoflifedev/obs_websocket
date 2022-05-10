// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneListResponse _$SceneListResponseFromJson(Map<String, dynamic> json) =>
    SceneListResponse(
      messageId: json['message-id'] as String,
      currentScene: json['current-scene'] as String,
      scenes: (json['scenes'] as List<dynamic>)
          .map((e) => Scene.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneListResponseToJson(SceneListResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'current-scene': instance.currentScene,
      'scenes': instance.scenes,
    };
