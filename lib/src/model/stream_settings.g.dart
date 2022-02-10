// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamSettings _$StreamSettingsFromJson(Map<String, dynamic> json) =>
    StreamSettings(
      server: json['server'] as String?,
      key: json['key'] as String?,
      useAuth: json['use_auth'] as bool?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$StreamSettingsToJson(StreamSettings instance) =>
    <String, dynamic>{
      'server': instance.server,
      'key': instance.key,
      'use_auth': instance.useAuth,
      'username': instance.username,
      'password': instance.password,
    };
