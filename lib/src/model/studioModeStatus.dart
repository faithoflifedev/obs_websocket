import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'studioModeStatus.g.dart';

@JsonSerializable()
class StudioModeStatus {
  @JsonKey(name: 'studio-mode')
  final bool enabled;

  StudioModeStatus({required this.enabled});

  factory StudioModeStatus.fromJson(Map<String, dynamic> json) =>
      _$StudioModeStatusFromJson(json);

  Map<String, dynamic> toJson() => _$StudioModeStatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
