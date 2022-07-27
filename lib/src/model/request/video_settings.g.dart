// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoSettings _$VideoSettingsFromJson(Map<String, dynamic> json) =>
    VideoSettings(
      fpsNumerator: json['fpsNumerator'] as int?,
      fpsDenominator: json['fpsDenominator'] as int?,
      baseWidth: json['baseWidth'] as int?,
      baseHeight: json['baseHeight'] as int?,
      outputWidth: json['outputWidth'] as int?,
      outputHeight: json['outputHeight'] as int?,
    );

Map<String, dynamic> _$VideoSettingsToJson(VideoSettings instance) =>
    <String, dynamic>{
      'fpsNumerator': instance.fpsNumerator,
      'fpsDenominator': instance.fpsDenominator,
      'baseWidth': instance.baseWidth,
      'baseHeight': instance.baseHeight,
      'outputWidth': instance.outputWidth,
      'outputHeight': instance.outputHeight,
    };
