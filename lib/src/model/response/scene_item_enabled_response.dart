import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_item_enabled_response.g.dart';

@JsonSerializable()
class SceneItemEnabledResponse {
  final bool sceneItemEnabled;

  SceneItemEnabledResponse({
    required this.sceneItemEnabled,
  });

  factory SceneItemEnabledResponse.fromJson(Map<String, dynamic> json) =>
      _$SceneItemEnabledResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemEnabledResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
