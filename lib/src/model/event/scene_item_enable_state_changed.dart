import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart';

part 'scene_item_enable_state_changed.g.dart';

@JsonSerializable()
class SceneItemEnableStateChanged extends SceneItemEnabled {
  final bool sceneItemEnabled;

  SceneItemEnableStateChanged({
    required String sceneName,
    required int sceneItemId,
    required this.sceneItemEnabled,
  }) : super(
          sceneName: sceneName,
          sceneItemId: sceneItemId,
        );

  factory SceneItemEnableStateChanged.fromJson(Map<String, dynamic> json) =>
      _$SceneItemEnableStateChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SceneItemEnableStateChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
