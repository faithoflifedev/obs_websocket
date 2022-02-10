import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_state_event.g.dart';

///Enumerated states
enum StreamState {
  @JsonValue('StreamStarting')
  streamStarting,
  @JsonValue('StreamStarted')
  streamStarted,
  @JsonValue('StreamStopping')
  streamStopping,
  @JsonValue('StreamStopped')
  streamStopped
}

///A class that represents a group of events emitted by [ObsWebSocket].  These
///are [StreamState.streamStarting], [StreamState.streamStarted], [StreamState.streamStopping] and
///[StreamState.streamStopped].  The [type] attribute returns the [StreamState].
@JsonSerializable()
class StreamStateEvent {
  @JsonKey(name: 'preview-only')
  bool? previewOnly;
  String? type;

  StreamStateEvent({this.previewOnly});

  factory StreamStateEvent.fromJson(Map<String, dynamic> json, String type) {
    final streamStateEvent = _$StreamStateEventFromJson(json);

    streamStateEvent.type = type;

    return streamStateEvent;
  }

  // factory StreamStateEvent.fromJson(Map<String, dynamic> json) =>
  //     _$StreamStateEventFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStateEventToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
