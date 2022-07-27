import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'record_state_changed.g.dart';

@JsonSerializable()
class RecordStateChanged {
  final bool outputActive;
  final String outputState;
  final String outputPath;

  RecordStateChanged({
    required this.outputActive,
    required this.outputState,
    required this.outputPath,
  });

  factory RecordStateChanged.fromJson(Map<String, dynamic> json) =>
      _$RecordStateChangedFromJson(json);

  Map<String, dynamic> toJson() => _$RecordStateChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
