import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'source_screenshot_response.g.dart';

/// [imageData] Base64-encoded screenshot
@JsonSerializable()
class SourceScreenshotResponse {
  /// Base64-encoded screenshot
  final bool imageData;

  SourceScreenshotResponse({
    required this.imageData,
  });

  factory SourceScreenshotResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceScreenshotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceScreenshotResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
