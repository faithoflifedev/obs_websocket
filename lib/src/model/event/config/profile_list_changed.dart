import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'abstract_event.dart';

part 'profile_list_changed.g.dart';

/// The scene collection list has changed.
///
/// Complexity Rating: 1/5
/// Latest Supported RPC Version: 1
/// Added in v5.0.0
@JsonSerializable()
class ProfileListChanged implements BaseEvent {
  final List<String> profiles;

  ProfileListChanged({required this.profiles});

  factory ProfileListChanged.fromJson(Map<String, dynamic> json) =>
      _$ProfileListChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileListChangedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
