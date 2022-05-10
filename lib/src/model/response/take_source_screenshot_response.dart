import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'take_source_screenshot_response.g.dart';

@JsonSerializable()
class TakeSourceScreenshotResponse {
  ///	Source name
  final String sourceName;

  ///Image Data URI (if embedPictureFormat was specified in the request)
  String? img;

  ///Absolute path to the saved image file (if saveToFilePath was specified in the request)
  String? imageFile;

  TakeSourceScreenshotResponse(
      {required this.sourceName, this.img, this.imageFile});

  factory TakeSourceScreenshotResponse.fromJson(Map<String, dynamic> json) =>
      _$TakeSourceScreenshotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TakeSourceScreenshotResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
