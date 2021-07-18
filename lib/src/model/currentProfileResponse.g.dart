// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currentProfileResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentProfileResponse _$CurrentProfileResponseFromJson(
    Map<String, dynamic> json) {
  return CurrentProfileResponse(
    profileName: json['profile-name'] as String,
  );
}

Map<String, dynamic> _$CurrentProfileResponseToJson(
        CurrentProfileResponse instance) =>
    <String, dynamic>{
      'profile-name': instance.profileName,
    };
