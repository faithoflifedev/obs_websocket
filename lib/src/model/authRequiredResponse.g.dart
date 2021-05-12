// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authRequiredResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequiredResponse _$AuthRequiredResponseFromJson(Map<String, dynamic> json) {
  return AuthRequiredResponse(
    authRequired: json['authRequired'] as bool?,
    challenge: json['challenge'] as String?,
    messageId: json['message-id'] as String?,
    salt: json['salt'] as String?,
    rawStatus: json['status'] as String,
  );
}

Map<String, dynamic> _$AuthRequiredResponseToJson(
        AuthRequiredResponse instance) =>
    <String, dynamic>{
      'authRequired': instance.authRequired,
      'challenge': instance.challenge,
      'message-id': instance.messageId,
      'salt': instance.salt,
      'status': instance.rawStatus,
    };
