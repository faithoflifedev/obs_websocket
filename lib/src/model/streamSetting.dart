import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'streamSettings.dart';

part 'streamSetting.g.dart';

@JsonSerializable()
class StreamSetting {
  final String type;
  final StreamSettings settings;

  StreamSetting({required this.type, required this.settings});

  factory StreamSetting.fromJson(Map<String, dynamic> json) =>
      _$StreamSettingFromJson(json);

  Map<String, dynamic> toJson() => _$StreamSettingToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
