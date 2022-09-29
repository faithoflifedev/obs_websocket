import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'abstract_event.dart';

part 'current_scene_collection_changed.g.dart';

/// The current scene collection has changed.
///
/// Note: If polling has been paused during CurrentSceneCollectionChanging, this is the que to restart polling.
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class CurrentSceneCollectionChanged implements BaseEvent {
  final String sceneCollectionName;

  CurrentSceneCollectionChanged({required this.sceneCollectionName});

  factory CurrentSceneCollectionChanged.fromJson(Map<String, dynamic> json) =>
      _$CurrentSceneCollectionChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CurrentSceneCollectionChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
