// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupListResponse _$GroupListResponseFromJson(Map<String, dynamic> json) =>
    GroupListResponse(
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GroupListResponseToJson(GroupListResponse instance) =>
    <String, dynamic>{
      'groups': instance.groups,
    };
