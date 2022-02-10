import 'package:json_annotation/json_annotation.dart';

part 'stream_settings_response.g.dart';

@JsonSerializable()
class StreamSettingsResponse {
  final String type;
  final dynamic settings;

  StreamSettingsResponse(this.type, this.settings);

  factory StreamSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$StreamSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StreamSettingsResponseToJson(this);
}
