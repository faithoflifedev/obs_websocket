import 'package:obs_websocket/src/model/event/sceneItemVisibilityChanged.dart';
import 'package:obs_websocket/src/model/event/streamStatusEvent.dart';

class BaseEvent {
  final String updateType;
  final Map<String, dynamic> rawEvent;

  BaseEvent(this.updateType, this.rawEvent);

  factory BaseEvent.fromJson(Map<String, dynamic> json) {
    return BaseEvent(json['update-type'], json);
  }

  StreamStatusEvent asSteamStatusEvent() {
    if (updateType != 'StreamStatus') throw Exception('wrong type');
    return StreamStatusEvent.fromJson(this.rawEvent);
  }

  SceneItemVisibilityChanged asSceneItemVisibilityChangedEvent() {
    if (updateType != 'SceneItemVisibilityChanged')
      throw Exception('wrong type');
    return SceneItemVisibilityChanged.fromJson(this.rawEvent);
  }
}
