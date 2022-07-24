import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item.g.dart';

@JsonSerializable()
class SceneItem {
  final String sceneName;
  final int sceneItemId;

  SceneItem({
    required this.sceneName,
    required this.sceneItemId,
  });

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemToJson(this);

  @override
  String toString() => json.encode(toJson());
}
