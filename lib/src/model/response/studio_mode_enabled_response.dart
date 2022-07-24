import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'studio_mode_enabled_response.g.dart';

@JsonSerializable()
class StudioModeEnabledResponse {
  final bool studioModeEnabled;

  StudioModeEnabledResponse({
    required this.studioModeEnabled,
  });

  factory StudioModeEnabledResponse.fromJson(Map<String, dynamic> json) =>
      _$StudioModeEnabledResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudioModeEnabledResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
