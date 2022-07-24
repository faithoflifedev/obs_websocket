// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_service_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamServiceSettingsResponse _$StreamServiceSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    StreamServiceSettingsResponse(
      streamServiceType: json['streamServiceType'],
      streamServiceSettings: json['streamServiceSettings'],
    );

Map<String, dynamic> _$StreamServiceSettingsResponseToJson(
        StreamServiceSettingsResponse instance) =>
    <String, dynamic>{
      'streamServiceType': instance.streamServiceType,
      'streamServiceSettings': instance.streamServiceSettings,
    };
