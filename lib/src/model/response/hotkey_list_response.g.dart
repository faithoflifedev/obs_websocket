// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotkey_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotkeyListResponse _$HotkeyListResponseFromJson(Map<String, dynamic> json) =>
    HotkeyListResponse(
      hotkeys:
          (json['hotkeys'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotkeyListResponseToJson(HotkeyListResponse instance) =>
    <String, dynamic>{
      'hotkeys': instance.hotkeys,
    };
