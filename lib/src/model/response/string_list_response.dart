import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'string_list_response.g.dart';

@JsonSerializable(createToJson: false)
class StringListResponse {
  final List<String> items;

  StringListResponse({
    required this.items,
  });

  factory StringListResponse.fromJson(Map<String, dynamic> json) =>
      _$StringListResponseFromJson(json);
}

@JsonSerializable()
class Hotkeys extends StringListResponse {
  final List<String> hotkeys;

  Hotkeys({
    required this.hotkeys,
  }) : super(items: hotkeys);

  factory Hotkeys.fromJson(Map<String, dynamic> json) =>
      _$HotkeysFromJson(json);

  Map<String, dynamic> toJson() => _$HotkeysToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable()
class Groups extends StringListResponse {
  final List<String> groups;

  Groups({
    required this.groups,
  }) : super(items: groups);

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsToJson(this);

  @override
  String toString() => json.encode(toJson());
}
