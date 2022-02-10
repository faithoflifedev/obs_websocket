import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../scene_item.dart';

part 'scene_item_response.g.dart';

@JsonSerializable()
class SceneItemResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  final List<SceneItem> sceneItems;

  SceneItemResponse({required this.messageId, required this.sceneItems});

  factory SceneItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
