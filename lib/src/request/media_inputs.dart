import 'package:obs_websocket/obs_websocket.dart';

/// Media Inputs Requests
class MediaInputs {
  final ObsWebSocket obsWebSocket;

  MediaInputs(this.obsWebSocket);

  /// Sets the cursor position of a media input.
  ///
  /// This request does not perform bounds checking of the cursor position.
  ///
  /// - Complexity Rating: 1/5
  /// - Latest Supported RPC Version: 1
  /// - Added in v5.0.0
  /// **Request Fields:**
  ///
  /// | Name | Type  | Description | Value Restrictions | ?Default Behavior |
  /// | ---- | :---: | ----------- | :----------------: | ----------------- |
  /// | [inputName] | String | Name of the media input | None | N/A |
  /// | [mediaCursor] | Number | New cursor position to set | >= 0 | N/A |
  Future<void> setMediaInputCursor(
          {required String inputName, required int mediaCursor}) async =>
      await obsWebSocket.sendRequest(Request(
        'SetMediaInputCursor',
        requestData: {'inputName': inputName, 'mediaCursor': mediaCursor},
      ));
}
