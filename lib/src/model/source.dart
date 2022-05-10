import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  ///Unique source name
  final String name;

  ///Non-unique source internal type (a.k.a kind)
  final String typeId;

  ///Source type. Value is one of the following: "input", "filter", "transition", "scene" or "unknown"
  final String type;

  Source({required this.name, required this.typeId, required this.type});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  String toString() => json.encode(toJson());
}
