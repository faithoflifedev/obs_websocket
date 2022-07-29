// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanResponse _$BooleanResponseFromJson(Map<String, dynamic> json) =>
    BooleanResponse(
      enabled: json['enabled'] as bool,
    );

OutputActive _$OutputActiveFromJson(Map<String, dynamic> json) => OutputActive(
      outputActive: json['outputActive'] as bool,
    );

Map<String, dynamic> _$OutputActiveToJson(OutputActive instance) =>
    <String, dynamic>{
      'outputActive': instance.outputActive,
    };

SceneItemEnabled _$SceneItemEnabledFromJson(Map<String, dynamic> json) =>
    SceneItemEnabled(
      sceneItemEnabled: json['sceneItemEnabled'] as bool,
    );

Map<String, dynamic> _$SceneItemEnabledToJson(SceneItemEnabled instance) =>
    <String, dynamic>{
      'sceneItemEnabled': instance.sceneItemEnabled,
    };

StudioModeEnabled _$StudioModeEnabledFromJson(Map<String, dynamic> json) =>
    StudioModeEnabled(
      sceneItemEnabled: json['sceneItemEnabled'] as bool,
    );

Map<String, dynamic> _$StudioModeEnabledToJson(StudioModeEnabled instance) =>
    <String, dynamic>{
      'sceneItemEnabled': instance.sceneItemEnabled,
    };
