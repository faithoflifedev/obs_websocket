// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamSetting _$StreamSettingFromJson(Map<String, dynamic> json) =>
    StreamSetting(
      type: json['type'] as String,
      settings:
          StreamSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamSettingToJson(StreamSetting instance) =>
    <String, dynamic>{
      'type': instance.type,
      'settings': instance.settings,
    };
