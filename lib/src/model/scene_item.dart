import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item.g.dart';

///Represents an OBS SceneItem
@JsonSerializable()
class SceneItem {
  final int itemId;
  final String sourceKind;
  final String sourceName;
  final String sourceType;

  SceneItem(
      {required this.itemId,
      required this.sourceKind,
      required this.sourceName,
      required this.sourceType});

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemToJson(this);

  @override
  String toString() => json.encode(toJson());
}
