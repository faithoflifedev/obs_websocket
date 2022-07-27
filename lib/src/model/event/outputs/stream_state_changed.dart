import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart' show StreamState;

part 'stream_state_changed.g.dart';

@JsonSerializable()
class StreamStateChanged extends StreamState {
  StreamStateChanged({
    required outputActive,
    required outputState,
  }) : super(
          outputActive: outputActive,
          outputState: outputState,
        );

  factory StreamStateChanged.fromJson(Map<String, dynamic> json) =>
      _$StreamStateChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StreamStateChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
