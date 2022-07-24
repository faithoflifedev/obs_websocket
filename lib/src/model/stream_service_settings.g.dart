// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_service_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamServiceSettings _$StreamServiceSettingsFromJson(
        Map<String, dynamic> json) =>
    StreamServiceSettings(
      streamServiceType: json['streamServiceType'] as String,
      streamServiceSettings:
          json['streamServiceSettings'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$StreamServiceSettingsToJson(
        StreamServiceSettings instance) =>
    <String, dynamic>{
      'streamServiceType': instance.streamServiceType,
      'streamServiceSettings': instance.streamServiceSettings,
    };
