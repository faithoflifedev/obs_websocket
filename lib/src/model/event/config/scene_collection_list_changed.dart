import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'scene_collection_list_changed.g.dart';

/// The scene collection list has changed.
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class SceneCollectionListChanged {
  final List<String> sceneCollections;

  SceneCollectionListChanged({required this.sceneCollections});

  factory SceneCollectionListChanged.fromJson(Map<String, dynamic> json) =>
      _$SceneCollectionListChangedFromJson(json);

  Map<String, dynamic> toJson() => _$SceneCollectionListChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
