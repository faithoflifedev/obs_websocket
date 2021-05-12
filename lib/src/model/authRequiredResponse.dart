import 'package:json_annotation/json_annotation.dart';

part 'authRequiredResponse.g.dart';

@JsonSerializable()
class AuthRequiredResponse {
  final bool? authRequired;

  final String? challenge;

  @JsonKey(name: 'message-id')
  final String? messageId;

  final String? salt;

  @JsonKey(name: 'status')
  final String rawStatus;

  bool get status => rawStatus.toLowerCase() == 'ok';

  AuthRequiredResponse(
      {this.authRequired,
      this.challenge,
      this.messageId,
      this.salt,
      required this.rawStatus});

  factory AuthRequiredResponse.init() => AuthRequiredResponse(rawStatus: '');

  factory AuthRequiredResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthRequiredResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequiredResponseToJson(this);
}
