import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'hotkey_list_response.g.dart';

@JsonSerializable()
class HotkeyListResponse {
  final List<String> hotkeys;

  HotkeyListResponse({
    required this.hotkeys,
  });

  factory HotkeyListResponse.fromJson(Map<String, dynamic> json) =>
      _$HotkeyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotkeyListResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
