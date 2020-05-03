class AuthRequired {
  bool authRequired;
  String challenge;
  int messageId;
  String salt;
  bool status;

  AuthRequired(this.authRequired, this.challenge, this.messageId, this.salt,
      this.status);

  AuthRequired.fromJson(Map<String, dynamic> json)
      : authRequired = json['authRequired'],
        challenge = json['challenge'],
        messageId = int.parse(json['message-id']),
        salt = json['salt'],
        status = json['status'] == "ok";

  Map<String, dynamic> toJson() => {
        'authRequired': authRequired,
        'challenge': challenge,
        'message-id': messageId.toString(),
        'salt': salt,
        'status': status ? "ok" : ""
      };
}

class SimpleResponse {
  String error;
  int messageId;
  bool status;

  SimpleResponse(this.error, this.messageId, this.status);

  SimpleResponse.fromJson(Map<String, dynamic> json)
      : error = json.containsKey("error") ? json["error"] : "",
        messageId = int.parse(json['message-id']),
        status = json['status'] == "ok";

  Map<String, dynamic> toJson() => {
        "error": error,
        "message-id": messageId.toString(),
        "status": status ? "ok" : ""
      };
}