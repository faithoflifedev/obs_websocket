import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../scene.dart';

part 'scene_list_response.g.dart';

@JsonSerializable()
class SceneListResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  @JsonKey(name: 'current-scene')
  final String currentScene;

  final List<Scene> scenes;

  SceneListResponse(
      {required this.messageId,
      required this.currentScene,
      required this.scenes});

  factory SceneListResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneListResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
