import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stream_status_response.g.dart';

@JsonSerializable()
class StreamStatusResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  @JsonKey(name: 'preview-only')
  final bool previewOnly;

  @JsonKey(name: 'recording')
  final bool recording;

  @JsonKey(name: 'recording-paused')
  final bool recordingPaused;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'streaming')
  final bool streaming;

  StreamStatusResponse(this.messageId, this.previewOnly, this.recording,
      this.recordingPaused, this.status, this.streaming);

  factory StreamStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StreamStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StreamStatusResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
