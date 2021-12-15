import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'source.dart';

part 'sourcesListResponse.g.dart';

@JsonSerializable()
class SourcesListResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  final List<Source> sources;

  final String status;

  SourcesListResponse(
      {required this.messageId, required this.sources, required this.status});

  factory SourcesListResponse.fromJson(Map<String, dynamic> json) =>
      _$SourcesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
