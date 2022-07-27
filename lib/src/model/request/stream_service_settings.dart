import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_service_settings.g.dart';

@JsonSerializable()
class StreamServiceSettings {
  final String streamServiceType;
  final Map<String, dynamic> streamServiceSettings;

  StreamServiceSettings({
    required this.streamServiceType,
    required this.streamServiceSettings,
  });

  factory StreamServiceSettings.fromJson(Map<String, dynamic> json) =>
      _$StreamServiceSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$StreamServiceSettingsToJson(this);

  @override
  String toString() => json.encode(toJson());
}
