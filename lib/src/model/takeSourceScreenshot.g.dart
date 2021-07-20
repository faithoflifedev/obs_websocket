// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'takeSourceScreenshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TakeSourceScreenshot _$TakeSourceScreenshotFromJson(
        Map<String, dynamic> json) =>
    TakeSourceScreenshot(
      sourceName: json['sourceName'] as String,
      embedPictureFormat: json['embedPictureFormat'] as String?,
      saveToFilePath: json['saveToFilePath'] as String?,
      fileFormat: json['fileFormat'] as String?,
      compressionQuality: json['compressionQuality'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$TakeSourceScreenshotToJson(
        TakeSourceScreenshot instance) =>
    <String, dynamic>{
      'sourceName': instance.sourceName,
      'embedPictureFormat': instance.embedPictureFormat,
      'saveToFilePath': instance.saveToFilePath,
      'fileFormat': instance.fileFormat,
      'compressionQuality': instance.compressionQuality,
      'width': instance.width,
      'height': instance.height,
    };
