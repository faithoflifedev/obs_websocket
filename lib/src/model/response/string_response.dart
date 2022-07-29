import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'string_response.g.dart';

@JsonSerializable(createToJson: false)
class StringResponse {
  final String value;

  StringResponse({
    required this.value,
  });

  factory StringResponse.fromJson(Map<String, dynamic> json) =>
      _$StringResponseFromJson(json);
}

@JsonSerializable()
class OutputPath extends StringResponse {
  final String outputPath;

  OutputPath({required this.outputPath}) : super(value: outputPath);

  factory OutputPath.fromJson(Map<String, dynamic> json) =>
      _$OutputPathFromJson(json);

  Map<String, dynamic> toJson() => _$OutputPathToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class CurrentProgramSceneName extends StringResponse {
  final String currentProgramSceneName;

  CurrentProgramSceneName({required this.currentProgramSceneName})
      : super(value: currentProgramSceneName);

  factory CurrentProgramSceneName.fromJson(Map<String, dynamic> json) =>
      _$CurrentProgramSceneNameFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentProgramSceneNameToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class CurrentPreviewSceneName extends StringResponse {
  final String currentPreviewSceneName;

  CurrentPreviewSceneName({required this.currentPreviewSceneName})
      : super(value: currentPreviewSceneName);

  factory CurrentPreviewSceneName.fromJson(Map<String, dynamic> json) =>
      _$CurrentPreviewSceneNameFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentPreviewSceneNameToJson(this);

  @override
  String toString() => json.encode(toJson());
}
