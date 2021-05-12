import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'sceneDetail.dart';

part 'sceneItem.g.dart';

@JsonSerializable()
class SceneItem {
  final String name;
  final List<SceneDetail> sources;

  SceneItem({required this.name, required this.sources});

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
