class BaseResponse {
  final String? error;
  final String? messageId;
  final String? rawStatus;
  final Map<String, dynamic> rawResponse;

  bool get status => rawStatus != null && rawStatus!.toLowerCase() == 'ok';

  BaseResponse(
      {this.error, this.messageId, this.rawStatus, required this.rawResponse});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        error: json.containsKey('error') ? json['error'] : '',
        messageId: json['message-id'],
        rawStatus: json['status'],
        rawResponse: json);
  }
}
