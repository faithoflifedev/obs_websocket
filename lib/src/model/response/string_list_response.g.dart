// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringListResponse _$StringListResponseFromJson(Map<String, dynamic> json) =>
    StringListResponse(
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
    );

Hotkeys _$HotkeysFromJson(Map<String, dynamic> json) => Hotkeys(
      hotkeys:
          (json['hotkeys'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotkeysToJson(Hotkeys instance) => <String, dynamic>{
      'hotkeys': instance.hotkeys,
    };

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'groups': instance.groups,
    };
