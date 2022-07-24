import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'toggle_stream_response.g.dart';

@JsonSerializable()
class ToggleStreamResponse {
  final bool outputActive;

  ToggleStreamResponse({
    required this.outputActive,
  });

  factory ToggleStreamResponse.fromJson(Map<String, dynamic> json) =>
      _$ToggleStreamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleStreamResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
