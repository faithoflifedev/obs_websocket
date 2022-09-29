import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'abstract_event.dart';

part 'current_profile_changing.g.dart';

/// The current profile has begun changing.
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class CurrentProfileChanging implements BaseEvent {
  final String profileName;

  CurrentProfileChanging({required this.profileName});

  factory CurrentProfileChanging.fromJson(Map<String, dynamic> json) =>
      _$CurrentProfileChangingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CurrentProfileChangingToJson(this);

  @override
  String toString() => json.encode(toJson());
}
