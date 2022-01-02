// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mediaSourcesListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaSourcesListResponse _$MediaSourcesListResponseFromJson(
        Map<String, dynamic> json) =>
    MediaSourcesListResponse(
      messageId: json['message-id'] as String,
      mediaSources: (json['mediaSources'] as List<dynamic>)
          .map((e) => MediaSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$MediaSourcesListResponseToJson(
        MediaSourcesListResponse instance) =>
    <String, dynamic>{
      'message-id': instance.messageId,
      'mediaSources': instance.mediaSources,
      'status': instance.status,
    };
