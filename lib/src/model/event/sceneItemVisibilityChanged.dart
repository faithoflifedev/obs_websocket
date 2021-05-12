import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneItemVisibilityChanged.g.dart';

@JsonSerializable()
class SceneItemVisibilityChanged {
  @JsonKey(name: 'item-id')
  final int itemId;

  @JsonKey(name: 'item-name')
  final String itemName;

  @JsonKey(name: 'item-visible')
  final bool itemVisible;

  @JsonKey(name: 'scene-name')
  final String sceneName;

  SceneItemVisibilityChanged(
      {required this.itemId,
      required this.itemName,
      required this.itemVisible,
      required this.sceneName});

  factory SceneItemVisibilityChanged.fromJson(Map<String, dynamic> json) =>
      _$SceneItemVisibilityChangedFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemVisibilityChangedToJson(this);

  Map<String, dynamic> asArgs() => {
        'scene-name': this.sceneName,
        'source': this.itemName,
        'item': this.itemId,
        'render': this.itemVisible
      };

  @override
  String toString() => jsonEncode(toJson());
}
