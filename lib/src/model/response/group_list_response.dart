import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'group_list_response.g.dart';

@JsonSerializable()
class GroupListResponse {
  final List<String> groups;

  GroupListResponse({
    required this.groups,
  });

  factory GroupListResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupListResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
