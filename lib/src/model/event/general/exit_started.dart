import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'exit_started.g.dart';

@JsonSerializable()
class ExitStarted {
  ExitStarted();

  factory ExitStarted.fromJson(Map<String, dynamic> json) =>
      _$ExitStartedFromJson(json);

  Map<String, dynamic> toJson() => _$ExitStartedToJson(this);

  @override
  String toString() => json.encode(toJson());
}
