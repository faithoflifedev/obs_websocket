import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'current_scene_collection_changing.g.dart';

/// The current scene collection has begun changing.
///
/// Note: We recommend using this event to trigger a pause of all polling requests, as performing any requests during a scene collection change is considered undefined behavior and can cause crashes!
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class CurrentSceneCollectionChanging {
  final String sceneCollectionName;

  CurrentSceneCollectionChanging({required this.sceneCollectionName});

  factory CurrentSceneCollectionChanging.fromJson(Map<String, dynamic> json) =>
      _$CurrentSceneCollectionChangingFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentSceneCollectionChangingToJson(this);

  @override
  String toString() => json.encode(toJson());
}
