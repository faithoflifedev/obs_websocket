// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourcesListResponse _$SourcesListResponseFromJson(Map<String, dynamic> json) =>
    SourcesListResponse(
      messageId: json['message-id'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$SourcesListResponseToJson(
        SourcesListResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'sources': instance.sources,
      'status': instance.status,
    };
