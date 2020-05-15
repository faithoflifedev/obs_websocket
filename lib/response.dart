import 'package:meta/meta.dart';

class AuthRequired {
  bool authRequired;
  String challenge;
  String messageId;
  String salt;
  bool status;

  AuthRequired(this.authRequired, this.challenge, this.messageId, this.salt,
      this.status);

  AuthRequired.fromJson(Map<String, dynamic> json)
      : authRequired = json['authRequired'],
        challenge = json['challenge'],
        messageId = json['message-id'],
        salt = json['salt'],
        status = json['status'] == "ok";

  Map<String, dynamic> toJson() => {
        'authRequired': authRequired,
        'challenge': challenge,
        'message-id': messageId,
        'salt': salt,
        'status': status ? "ok" : ""
      };
}

class SimpleResponse {
  final String error;
  final String messageId;
  final bool status;
  final Map<String, dynamic> raw;

  Map<String, dynamic> map;

  ///Constructor for responses from the websocket server, the full response is avalible through
  ///the [raw] attribute, but if the goal is to use the response as an argument for another ,
  ///command then the [map] attribute can be used, which removes the [error], [messageId] and
  ///[status] fields.
  SimpleResponse(
      {this.error,
      @required this.messageId,
      @required this.status,
      @required this.raw}) {
    map = Map<String, dynamic>.from(this.raw);

    map.remove("message-id");
    map.remove("error");
    map.remove("status");
  }

  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    return SimpleResponse(
        error: json.containsKey("error") ? json["error"] : "",
        messageId: json['message-id'],
        status: json['status'] == "ok",
        raw: json);
  }

  /* Map<String, dynamic> toJson() => {
        "error": error,
        "message-id": messageId.toString(),
        "status": status ? "ok" : ""
      }; */
}
