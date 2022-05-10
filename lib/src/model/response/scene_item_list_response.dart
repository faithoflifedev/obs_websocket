import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../scene_item.dart';

part 'scene_item_list_response.g.dart';

@JsonSerializable()
class SceneItemListResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  final String sceneName;

  final List<SceneItem> sceneItems;

  SceneItemListResponse(
      {required this.messageId,
      required this.sceneName,
      required this.sceneItems});

  factory SceneItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemListResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
