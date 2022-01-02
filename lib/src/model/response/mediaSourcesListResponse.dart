import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../mediaSource.dart';

part 'mediaSourcesListResponse.g.dart';

@JsonSerializable()
class MediaSourcesListResponse {
  @JsonKey(name: 'message-id')
  final String messageId;

  final List<MediaSource> mediaSources;

  final String status;

  MediaSourcesListResponse(
      {required this.messageId,
      required this.mediaSources,
      required this.status});

  factory MediaSourcesListResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaSourcesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MediaSourcesListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
