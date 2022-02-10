import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'current_profile_response.g.dart';

///response to the [ObsWebSocket.getCurrentScene] command
@JsonSerializable()
class CurrentProfileResponse {
  final String profileName;

  CurrentProfileResponse({required this.profileName});

  factory CurrentProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentProfileResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
