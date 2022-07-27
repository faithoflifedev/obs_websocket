import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene.g.dart';

@JsonSerializable()
class Scene {
  final String sceneName;
  final int sceneIndex;

  Scene({
    required this.sceneName,
    required this.sceneIndex,
  });

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

  Map<String, dynamic> toJson() => _$SceneToJson(this);

  @override
  String toString() => json.encode(toJson());
}
