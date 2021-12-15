import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'mediaSource.g.dart';

@JsonSerializable()
class MediaSource {
  final String sourceName;
  final String sourceKind;
  final String mediaState;

  MediaSource(
      {required this.sourceName,
      required this.sourceKind,
      required this.mediaState});

  factory MediaSource.fromJson(Map<String, dynamic> json) =>
      _$MediaSourceFromJson(json);

  Map<String, dynamic> toJson() => _$MediaSourceToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
