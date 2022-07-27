import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'studio_mode_enabled.g.dart';

@JsonSerializable()
class StudioModeEnabled {
  final bool studioModeEnabled;

  StudioModeEnabled({
    required this.studioModeEnabled,
  });

  factory StudioModeEnabled.fromJson(Map<String, dynamic> json) =>
      _$StudioModeEnabledFromJson(json);

  Map<String, dynamic> toJson() => _$StudioModeEnabledToJson(this);

  @override
  String toString() => json.encode(toJson());
}
