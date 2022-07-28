import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item_enable_state_changed.g.dart';

@JsonSerializable()
class SceneItemEnableStateChanged {
  final String sceneName;
  final int sceneItemId;
  final bool sceneItemEnabled;

  SceneItemEnableStateChanged({
    required this.sceneName,
    required this.sceneItemId,
    required this.sceneItemEnabled,
  });

  factory SceneItemEnableStateChanged.fromJson(Map<String, dynamic> json) =>
      _$SceneItemEnableStateChangedFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemEnableStateChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
