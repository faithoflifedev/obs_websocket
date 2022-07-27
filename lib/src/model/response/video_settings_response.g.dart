// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoSettingsResponse _$VideoSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    VideoSettingsResponse(
      fpsNumerator: json['fpsNumerator'] as int,
      fpsDenominator: json['fpsDenominator'] as int,
      baseWidth: json['baseWidth'] as int,
      baseHeight: json['baseHeight'] as int,
      outputWidth: json['outputWidth'] as int,
      outputHeight: json['outputHeight'] as int,
    );

Map<String, dynamic> _$VideoSettingsResponseToJson(
        VideoSettingsResponse instance) =>
    <String, dynamic>{
      'fpsDenominator': instance.fpsDenominator,
      'baseWidth': instance.baseWidth,
      'baseHeight': instance.baseHeight,
      'outputWidth': instance.outputWidth,
      'outputHeight': instance.outputHeight,
      'fpsNumerator': instance.fpsNumerator,
    };
