import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'abstract_event.dart';

part 'current_profile_changed.g.dart';

/// The current profile has changed.
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class CurrentProfileChanged implements BaseEvent {
  final String profileName;

  CurrentProfileChanged({required this.profileName});

  factory CurrentProfileChanged.fromJson(Map<String, dynamic> json) =>
      _$CurrentProfileChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CurrentProfileChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
