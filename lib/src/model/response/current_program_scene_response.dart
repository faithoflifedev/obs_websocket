import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'current_program_scene_response.g.dart';

@JsonSerializable()
class CurrentProgramSceneResponse {
  final String currentProgramSceneName;

  CurrentProgramSceneResponse({
    required this.currentProgramSceneName,
  });

  factory CurrentProgramSceneResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentProgramSceneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentProgramSceneResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
