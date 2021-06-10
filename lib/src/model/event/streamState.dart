import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'streamState.g.dart';

@JsonSerializable()
class StreamState {
  @JsonKey(name: 'preview-only')
  bool? previewOnly;
  String? type;

  StreamState({this.previewOnly});

  factory StreamState.fromJson(Map<String, dynamic> json, String type) {
    final streamState = _$StreamStateFromJson(json);

    streamState.type = type;

    return streamState;
  }

  // factory StreamState.fromJson(Map<String, dynamic> json) =>
  //     _$StreamStateFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStateToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
