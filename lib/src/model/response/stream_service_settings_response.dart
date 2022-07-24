import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:obs_websocket/obs_websocket.dart';

part 'stream_service_settings_response.g.dart';

@JsonSerializable()
class StreamServiceSettingsResponse extends StreamServiceSettings {
  StreamServiceSettingsResponse({
    required streamServiceType,
    required streamServiceSettings,
  }) : super(
          streamServiceType: streamServiceType,
          streamServiceSettings: streamServiceSettings,
        );

  factory StreamServiceSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$StreamServiceSettingsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StreamServiceSettingsResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
