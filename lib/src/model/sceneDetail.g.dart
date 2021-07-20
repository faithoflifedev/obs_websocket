// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneDetail _$SceneDetailFromJson(Map<String, dynamic> json) => SceneDetail(
      cy: (json['cy'] as num).toDouble(),
      cx: (json['cx'] as num).toDouble(),
      alignment: json['alignment'] as int,
      name: json['name'] as String,
      id: json['id'] as int,
      render: json['render'] as bool,
      muted: json['muted'] as bool,
      locked: json['locked'] as bool,
      source_cx: json['source_cx'] as int,
      source_cy: json['source_cy'] as int,
      type: json['type'] as String,
      volume: (json['volume'] as num).toDouble(),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      parentGroupName: json['parentGroupName'] as String?,
      groupChildren: (json['groupChildren'] as List<dynamic>?)
          ?.map((e) => SceneDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneDetailToJson(SceneDetail instance) =>
    <String, dynamic>{
      'cy': instance.cy,
      'cx': instance.cx,
      'alignment': instance.alignment,
      'name': instance.name,
      'id': instance.id,
      'render': instance.render,
      'muted': instance.muted,
      'locked': instance.locked,
      'source_cx': instance.source_cx,
      'source_cy': instance.source_cy,
      'type': instance.type,
      'volume': instance.volume,
      'x': instance.x,
      'y': instance.y,
      'parentGroupName': instance.parentGroupName,
      'groupChildren': instance.groupChildren,
    };
