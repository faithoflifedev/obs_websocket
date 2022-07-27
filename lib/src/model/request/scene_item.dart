import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart' show Scene;

part 'scene_item.g.dart';

@JsonSerializable()
class SceneItem extends Scene {
  final int sceneItemId;

  SceneItem({
    required String sceneName,
    required this.sceneItemId,
  }) : super(
          sceneName: sceneName,
          sceneIndex: sceneItemId,
        );

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SceneItemToJson(this);

  @override
  String toString() => json.encode(toJson());
}
