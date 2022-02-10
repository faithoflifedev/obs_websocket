// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamSettingsResponse _$StreamSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    StreamSettingsResponse(
      json['type'] as String,
      json['settings'],
    );

Map<String, dynamic> _$StreamSettingsResponseToJson(
        StreamSettingsResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'settings': instance.settings,
    };
