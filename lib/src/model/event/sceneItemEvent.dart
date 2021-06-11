import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneItemEvent.g.dart';

///Enumerated states
enum SceneItemChange {
  @JsonValue('SceneItemAdded')
  sceneItemAdded,
  @JsonValue('SceneItemRemoved')
  sceneItemRemoved,
  @JsonValue('SceneItemSelected')
  sceneItemSelected,
  @JsonValue('SceneItemDeselected')
  sceneItemDeselected
}

///A class that represents a group of events emitted by [ObsWebSocket].  These
///are [SceneItemChange.sceneItemAdded], [SceneItemChange.sceneItemRemoved], [SceneItemChange.sceneItemSelected] and
///[SceneItemChange.sceneItemDeselected].  The [type] attribute returns the [SceneItemChange].
@JsonSerializable()
class SceneItemEvent {
  @JsonKey(name: 'item-id')
  final int itemId;

  @JsonKey(name: 'item-name')
  final String itemName;

  @JsonKey(name: 'scene-name')
  final String sceneName;

  SceneItemChange? type;

  SceneItemEvent(
      {required this.itemId,
      required this.itemName,
      required this.sceneName,
      this.type});

  factory SceneItemEvent.fromJson(Map<String, dynamic> json, String type) {
    final sceneItemEvent = _$SceneItemEventFromJson(json);

    sceneItemEvent.type = type.sceneItemChange;

    return sceneItemEvent;
  }

  Map<String, dynamic> toJson() => _$SceneItemEventToJson(this);

  Map<String, dynamic> asArgs() =>
      {'scene-name': sceneName, 'source': itemName, 'item': itemId};

  @override
  String toString() => jsonEncode(toJson());
}
