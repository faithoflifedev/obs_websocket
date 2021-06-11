import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'recordingStateEvent.g.dart';

///Enumerated states
enum RecordingState {
  @JsonValue('RecordingStarting')
  recordingStarting,
  @JsonValue('RecordingStarted')
  recordingStarted,
  @JsonValue('RecordingStopping')
  recordingStopping,
  @JsonValue('RecordingStopped')
  recordingStopped,
  @JsonValue('RecordingPaused')
  recordingPaused,
  @JsonValue('RecordingResumed')
  recordingResumed
}

///A class that represents a group of events emitted by [ObsWebSocket].  These
///are [RecordingState.recordingStarting], [RecordingState.recordingStarted], [RecordingState.recordingStopping],
///[RecordingState.recordingStopped], [RecordingState.recordingPaused] and [RecordingState.recordingResumed].  The [type]
///attribute returns the [RecordingState].
///Note: In some cases recordingFilename is not provided in this event because
///this information is not available at the time this event is emitted.
@JsonSerializable()
class RecordingStateEvent {
  @JsonKey(name: 'recordingFilename')
  String? recordingFilename;
  RecordingState? type;

  RecordingStateEvent({this.recordingFilename, this.type});

  factory RecordingStateEvent.fromJson(Map<String, dynamic> json, String type) {
    final recordingStateEvent = _$RecordingStateEventFromJson(json);

    recordingStateEvent.type = type.recordingState;

    return recordingStateEvent;
  }

  Map<String, dynamic> toJson() => _$RecordingStateEventToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
