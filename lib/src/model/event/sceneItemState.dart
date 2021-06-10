import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneItemState.g.dart';

@JsonSerializable()
class SceneItemState {
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

  SceneItemState(
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

  factory SceneItemState.fromJson(Map<String, dynamic> json, String type) {
    final sceneItemState = _$SceneItemStateFromJson(json);

    sceneItemState.type = type;

    return sceneItemState;
  }

  Map<String, dynamic> toJson() => _$SceneItemStateToJson(this);

  Map<String, dynamic> asArgs() => {
        'scene-name': sceneName,
        'source': itemName,
        'item': itemId,
        'render': itemVisible
      };

  @override
  String toString() => jsonEncode(toJson());
}
