// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_item_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemProperty _$SceneItemPropertyFromJson(Map<String, dynamic> json) =>
    SceneItemProperty(
      name: json['name'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => SceneDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneItemPropertyToJson(SceneItemProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sources': instance.sources,
    };
