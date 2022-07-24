import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item_id_response.g.dart';

@JsonSerializable()
class SceneItemIdResponse {
  final int sceneItemId;

  SceneItemIdResponse({
    required this.sceneItemId,
  });

  factory SceneItemIdResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneItemIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemIdResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
