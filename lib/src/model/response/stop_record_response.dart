import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stop_record_response.g.dart';

@JsonSerializable()
class StopRecordResponse {
  final String outputPath;

  StopRecordResponse({
    required this.outputPath,
  });

  factory StopRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$StopRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StopRecordResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
