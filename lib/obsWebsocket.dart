///Messages are exchanged between the client and the server as JSON objects.
/// The protocol is based on the original OBS Remote protocol created by Bill
/// Hamilton, with new commands specific to OBS Studio.
library obs_websocket;

export 'src/model/event/baseEvent.dart';
export 'src/model/baseResponse.dart';
export 'src/model/streamSetting.dart';
export 'src/obs_websocket.dart';
