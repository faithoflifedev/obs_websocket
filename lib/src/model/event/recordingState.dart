import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'recordingState.g.dart';

@JsonSerializable()
class RecordingState {
  @JsonKey(name: 'recordingFilename')
  String? recordingFilename;
  String? type;

  RecordingState({this.recordingFilename, this.type});

  factory RecordingState.fromJson(Map<String, dynamic> json, String type) {
    final recordingState = _$RecordingStateFromJson(json);

    recordingState.type = type;

    return recordingState;
  }

  Map<String, dynamic> toJson() => _$RecordingStateToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
