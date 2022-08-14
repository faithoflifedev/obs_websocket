import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_state_changed.g.dart';

@JsonSerializable()
class StreamStateChanged {
  final String outputActive;
  final String outputState;

  StreamStateChanged({
    required this.outputActive,
    required this.outputState,
  });

  factory StreamStateChanged.fromJson(Map<String, dynamic> json) =>
      _$StreamStateChangedFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStateChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
