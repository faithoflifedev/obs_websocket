import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_settings.g.dart';

@JsonSerializable()
class StreamSettings {
  final String? server;
  final String? key;

  @JsonKey(name: 'use_auth')
  final bool? useAuth;

  final String? username;
  final String? password;

  // final bool save;

  StreamSettings({
    this.server,
    this.key,
    this.useAuth,
    this.username,
    this.password,
    // required this.save
  });

  factory StreamSettings.fromJson(Map<String, dynamic> json) =>
      _$StreamSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$StreamSettingsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
