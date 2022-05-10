import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'scene_detail.dart';

part 'scene_item_property.g.dart';

///Represents an OBS SceneItemProperty
@JsonSerializable()
class SceneItemProperty {
  final String name;
  final List<SceneDetail> sources;

  SceneItemProperty({required this.name, required this.sources});

  factory SceneItemProperty.fromJson(Map<String, dynamic> json) =>
      _$SceneItemPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemPropertyToJson(this);

  @override
  String toString() => json.encode(toJson());
}
