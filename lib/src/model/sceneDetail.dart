import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sceneDetail.g.dart';

///Represents an OBS SceneDetail
@JsonSerializable()
class SceneDetail {
  final double cy;
  final double cx;
  final int alignment;
  final String name;
  final int id;
  final bool render;
  final bool muted;
  final bool locked;
  final int source_cx;
  final int source_cy;
  final String type;
  final double volume;
  final double x;
  final double y;
  final String? parentGroupName;
  final List<SceneDetail>? groupChildren;

  SceneDetail(
      {required this.cy,
      required this.cx,
      required this.alignment,
      required this.name,
      required this.id,
      required this.render,
      required this.muted,
      required this.locked,
      required this.source_cx,
      required this.source_cy,
      required this.type,
      required this.volume,
      required this.x,
      required this.y,
      this.parentGroupName,
      this.groupChildren});

  factory SceneDetail.fromJson(Map<String, dynamic> json) =>
      _$SceneDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SceneDetailToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
