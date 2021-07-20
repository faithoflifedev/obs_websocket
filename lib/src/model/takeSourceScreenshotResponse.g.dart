// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'takeSourceScreenshotResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TakeSourceScreenshotResponse _$TakeSourceScreenshotResponseFromJson(
        Map<String, dynamic> json) =>
    TakeSourceScreenshotResponse(
      sourceName: json['sourceName'] as String,
      img: json['img'] as String?,
      imageFile: json['imageFile'] as String?,
    );

Map<String, dynamic> _$TakeSourceScreenshotResponseToJson(
        TakeSourceScreenshotResponse instance) =>
    <String, dynamic>{
      'sourceName': instance.sourceName,
      'img': instance.img,
      'imageFile': instance.imageFile,
    };
