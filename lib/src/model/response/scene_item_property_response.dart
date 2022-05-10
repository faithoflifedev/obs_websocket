import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../scene_item_property.dart';

part 'scene_item_property_response.g.dart';

@JsonSerializable()
class SceneItemPropertyResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  final List<SceneItemProperty> sceneItemProperties;

  SceneItemPropertyResponse(
      {required this.messageId, required this.sceneItemProperties});

  factory SceneItemPropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneItemPropertyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemPropertyResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
