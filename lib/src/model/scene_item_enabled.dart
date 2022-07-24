import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart';

part 'scene_item_enabled.g.dart';

@JsonSerializable()
class SceneItemEnabled extends SceneItem {
  SceneItemEnabled({
    required String sceneName,
    required int sceneItemId,
  }) : super(
          sceneName: sceneName,
          sceneItemId: sceneItemId,
        );

  factory SceneItemEnabled.fromJson(Map<String, dynamic> json) =>
      _$SceneItemEnabledFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SceneItemEnabledToJson(this);

  @override
  String toString() => json.encode(toJson());
}
