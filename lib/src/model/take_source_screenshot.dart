import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'take_source_screenshot.g.dart';

///At least embedPictureFormat or saveToFilePath must be specified.
///
///Clients can specify width and height parameters to receive scaled pictures. Aspect ratio is preserved if only one of these two parameters is specified.
@JsonSerializable()
class TakeSourceScreenshot {
  ///Source name. Note: Since scenes are also sources, you can also provide a scene name. Contrary to the docs, this field is required for the obs-websocket 4.9.1 protocol reference.
  final String? sourceName;

  ///Format of the Data URI encoded picture. Can be "png", "jpg", "jpeg" or "bmp" (or any other value supported by Qt's Image module)
  final String? embedPictureFormat;

  ///Full file path (file extension included) where the captured image is to be saved. Can be in a format different from pictureFormat. Contrary to the docs, can't be a relative path.
  final String? saveToFilePath;

  ///Format to save the image file as (one of the values provided in the supported-image-export-formats response field of GetVersion). If not specified, tries to guess based on file extension.
  final String? fileFormat;

  ///Compression ratio between -1 and 100 to write the image with. -1 is automatic, 1 is smallest file/most compression, 100 is largest file/least compression. Varies with image type.
  final int? compressionQuality;

  ///Screenshot width. Defaults to the source's base width.
  final int? width;

  ///Screenshot height. Defaults to the source's base height.
  final int? height;

  TakeSourceScreenshot(
      {required this.sourceName,
      this.embedPictureFormat,
      this.saveToFilePath,
      this.fileFormat,
      this.compressionQuality,
      this.width,
      this.height});

  factory TakeSourceScreenshot.fromJson(Map<String, dynamic> json) =>
      _$TakeSourceScreenshotFromJson(json);

  Map<String, dynamic> toJson() => _$TakeSourceScreenshotToJson(this);

  @override
  String toString() => json.encode(toJson());
}
