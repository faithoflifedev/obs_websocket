import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_state.g.dart';

@JsonSerializable()
class StreamState {
  final String outputActive;
  final String outputState;

  StreamState({
    required this.outputActive,
    required this.outputState,
  });

  factory StreamState.fromJson(Map<String, dynamic> json) =>
      _$StreamStateFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStateToJson(this);

  @override
  String toString() => json.encode(toJson());
}
