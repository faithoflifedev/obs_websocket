// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Monitor _$MonitorFromJson(Map<String, dynamic> json) => Monitor(
      monitorHeight: json['monitorHeight'] as int,
      monitorIndex: json['monitorIndex'] as int,
      monitorName: json['monitorName'] as String,
      monitorPositionX: json['monitorPositionX'] as int,
      monitorPositionY: json['monitorPositionY'] as int,
      monitorWidth: json['monitorWidth'] as int,
    );

Map<String, dynamic> _$MonitorToJson(Monitor instance) => <String, dynamic>{
      'monitorHeight': instance.monitorHeight,
      'monitorIndex': instance.monitorIndex,
      'monitorName': instance.monitorName,
      'monitorPositionX': instance.monitorPositionX,
      'monitorPositionY': instance.monitorPositionY,
      'monitorWidth': instance.monitorWidth,
    };
