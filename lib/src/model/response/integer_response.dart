import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'integer_response.g.dart';

@JsonSerializable(createToJson: false)
class IntegerResponse {
  final int itemId;

  IntegerResponse({
    required this.itemId,
  });

  factory IntegerResponse.fromJson(Map<String, dynamic> json) =>
      _$IntegerResponseFromJson(json);
}

@JsonSerializable()
class SceneItemId extends IntegerResponse {
  final int sceneItemId;

  SceneItemId({
    required this.sceneItemId,
  }) : super(itemId: sceneItemId);

  factory SceneItemId.fromJson(Map<String, dynamic> json) =>
      _$SceneItemIdFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemIdToJson(this);

  @override
  String toString() => json.encode(toJson());
}
