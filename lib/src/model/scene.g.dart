// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scene _$SceneFromJson(Map<String, dynamic> json) {
  return Scene(
    name: json['name'] as String,
    scenes: (json['sources'] as List<dynamic>)
        .map((e) => SceneDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
      'name': instance.name,
      'sources': instance.scenes,
    };
