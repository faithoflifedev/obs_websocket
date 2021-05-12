import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'sceneDetail.dart';

part 'scene.g.dart';

@JsonSerializable()
class Scene {
  final String name;

  @JsonKey(name: 'sources')
  final List<SceneDetail> scenes;

  final Map<String, SceneDetail> _sceneDetailMap;

  Scene({required this.name, required this.scenes})
      : _sceneDetailMap = Map.fromIterable(scenes,
            key: (sceneDetail) => sceneDetail.name,
            value: (sceneDetail) => sceneDetail);

  SceneDetail? getSceneDetail({required String withName}) =>
      _sceneDetailMap[withName];

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

  Map<String, dynamic> toJson() => _$SceneToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
