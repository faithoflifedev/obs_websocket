import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart' show SceneItem;

part 'scene_item_selected.g.dart';

/// A scene item has been selected in the Ui.
@JsonSerializable()
class SceneItemSelected extends SceneItem {
  SceneItemSelected({
    required String sceneName,
    required int sceneItemId,
  }) : super(
          sceneName: sceneName,
          sceneItemId: sceneItemId,
        );

  factory SceneItemSelected.fromJson(Map<String, dynamic> json) =>
      _$SceneItemSelectedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SceneItemSelectedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
