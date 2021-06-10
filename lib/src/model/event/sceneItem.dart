import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneItem.g.dart';

@JsonSerializable()
class SceneItem {
  @JsonKey(name: 'item-id')
  final int itemId;

  @JsonKey(name: 'item-name')
  final String itemName;

  @JsonKey(name: 'scene-name')
  final String sceneName;

  String? type;

  SceneItem(
      {required this.itemId,
      required this.itemName,
      required this.sceneName,
      this.type});

  factory SceneItem.fromJson(Map<String, dynamic> json, String type) {
    final sceneItem = _$SceneItemFromJson(json);

    sceneItem.type = type;

    return sceneItem;
  }

  Map<String, dynamic> toJson() => _$SceneItemToJson(this);

  Map<String, dynamic> asArgs() =>
      {'scene-name': sceneName, 'source': itemName, 'item': itemId};

  @override
  String toString() => jsonEncode(toJson());
}
