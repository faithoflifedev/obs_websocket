// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_screenshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceScreenshot _$SourceScreenshotFromJson(Map<String, dynamic> json) =>
    SourceScreenshot(
      sourceName: json['sourceName'] as String,
      imageFormat: json['imageFormat'] as String,
      imageFilePath: json['imageFilePath'] as String?,
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
      imageCompressionQuality: json['imageCompressionQuality'] as int?,
    );

Map<String, dynamic> _$SourceScreenshotToJson(SourceScreenshot instance) =>
    <String, dynamic>{
      'sourceName': instance.sourceName,
      'imageFormat': instance.imageFormat,
      'imageFilePath': instance.imageFilePath,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageCompressionQuality': instance.imageCompressionQuality,
    };
