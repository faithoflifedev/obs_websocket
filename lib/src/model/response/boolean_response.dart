import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'boolean_response.g.dart';

@JsonSerializable(createToJson: false)
class BooleanResponse {
  final bool enabled;

  BooleanResponse({
    required this.enabled,
  });

  factory BooleanResponse.fromJson(Map<String, dynamic> json) =>
      _$BooleanResponseFromJson(json);
}

@JsonSerializable()
class OutputActive extends BooleanResponse {
  final bool outputActive;

  OutputActive({required this.outputActive}) : super(enabled: outputActive);

  factory OutputActive.fromJson(Map<String, dynamic> json) =>
      _$OutputActiveFromJson(json);

  Map<String, dynamic> toJson() => _$OutputActiveToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class SceneItemEnabled extends BooleanResponse {
  final bool sceneItemEnabled;

  SceneItemEnabled({required this.sceneItemEnabled})
      : super(enabled: sceneItemEnabled);

  factory SceneItemEnabled.fromJson(Map<String, dynamic> json) =>
      _$SceneItemEnabledFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemEnabledToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class StudioModeEnabled extends BooleanResponse {
  final bool sceneItemEnabled;

  StudioModeEnabled({required this.sceneItemEnabled})
      : super(enabled: sceneItemEnabled);

  factory StudioModeEnabled.fromJson(Map<String, dynamic> json) =>
      _$StudioModeEnabledFromJson(json);

  Map<String, dynamic> toJson() => _$StudioModeEnabledToJson(this);

  @override
  String toString() => json.encode(toJson());
}
