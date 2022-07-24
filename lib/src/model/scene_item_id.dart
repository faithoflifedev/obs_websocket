import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item_id.g.dart';

@JsonSerializable()
class SceneItemId {
  final String sceneName;
  final String sourceName;
  final int? searchOffset;

  SceneItemId(
      {required this.sceneName, required this.sourceName, this.searchOffset});

  factory SceneItemId.fromJson(Map<String, dynamic> json) =>
      _$SceneItemIdFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemIdToJson(this);

  @override
  String toString() => json.encode(toJson());
}
