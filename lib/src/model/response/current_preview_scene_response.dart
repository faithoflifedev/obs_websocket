import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'current_preview_scene_response.g.dart';

@JsonSerializable()
class CurrentPreviewSceneResponse {
  final String currentPreviewSceneName;

  CurrentPreviewSceneResponse({
    required this.currentPreviewSceneName,
  });

  factory CurrentPreviewSceneResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentPreviewSceneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentPreviewSceneResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
