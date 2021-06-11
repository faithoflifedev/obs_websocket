import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneItemStateEvent.g.dart';

///Enumerated states
enum SceneItemState {
  @JsonValue('SceneItemVisibilityChanged')
  sceneItemVisibilityChanged,
  @JsonValue('SceneItemLockChanged')
  sceneItemLockChanged
}

///A class that represents a group of events emitted by [ObsWebSocket].  These
///are [SceneItemState.sceneItemVisibilityChanged] and [SceneItemState.sceneItemLockChanged].  The [type]
///attribute returns the [SceneItemState].
@JsonSerializable()
class SceneItemStateEvent {
  @JsonKey(name: 'item-id')
  final int itemId;

  @JsonKey(name: 'item-name')
  final String itemName;

  @JsonKey(name: 'item-visible')
  bool? itemVisible;

  @JsonKey(name: 'item-locked')
  bool? itemLocked;

  @JsonKey(name: 'scene-name')
  final String sceneName;

  String? type;

  SceneItemStateEvent(
      {required this.itemId,
      required this.itemName,
      this.itemVisible,
      this.itemLocked,
      required this.sceneName,
      this.type});

  bool get state {
    bool? _state = itemVisible ?? itemLocked ?? null;

    if (_state == null) throw Exception();

    return _state;
  }

  factory SceneItemStateEvent.fromJson(Map<String, dynamic> json, String type) {
    final sceneItemStateEvent = _$SceneItemStateEventFromJson(json);

    sceneItemStateEvent.type = type;

    return sceneItemStateEvent;
  }

  Map<String, dynamic> toJson() => _$SceneItemStateEventToJson(this);

  Map<String, dynamic> toSceneItemRenderMap(bool render) => {
        'scene-name': sceneName,
        'source': itemName,
        'item': itemId,
        'render': render
      };

  @override
  String toString() => jsonEncode(toJson());
}
