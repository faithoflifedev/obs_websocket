import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'mediaStateResponse.g.dart';

///response to the [ObsWebSocket.getMediaState] command
@JsonSerializable()
class MediaStateResponse {
  final String mediaState;

  MediaStateResponse({required this.mediaState});

  factory MediaStateResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaStateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MediaStateResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
