import 'package:obs_websocket/src/model/event/recordingStateEvent.dart';
import 'package:obs_websocket/src/model/event/sceneItemEvent.dart';
import 'package:obs_websocket/src/model/event/sceneItemStateEvent.dart';
import 'package:obs_websocket/src/model/event/streamStateEvent.dart';
import 'package:obs_websocket/src/model/event/streamStatusEvent.dart';

///A class that represents an event emitted by the [ObsWebSocket] the a
class BaseEvent {
  final String updateType;
  final Map<String, dynamic> rawEvent;

  static final Exception exception = Exception('Wrong event type');

  BaseEvent(this.updateType, this.rawEvent);

  factory BaseEvent.fromJson(Map<String, dynamic> json) {
    return BaseEvent(json['update-type'], json);
  }

  ///returns a [StreamStatusEvent], [RecordingStateEvent], [SceneItemEvent], [SceneItemStateEvent],
  ///[StreamStateEvent] object or an [Exception] if [BaseEvent] doesn't match the
  ///[Type] provided.
  Object asEvent<T>() {
    switch (T.toString()) {
      case 'StreamStatusEvent':
        return StreamStatusEvent.fromJson(rawEvent);

      case 'RecordingStateEvent':
        return RecordingStateEvent.fromJson(rawEvent, updateType);

      case 'SceneItemEvent':
        return SceneItemEvent.fromJson(rawEvent, updateType);

      case 'SceneItemStateEvent':
        return SceneItemStateEvent.fromJson(rawEvent, updateType);

      case 'StreamStateEvent':
        return StreamStateEvent.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [RecordingState] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  @deprecated
  RecordingStateEvent asRecordingStateEvent() {
    switch (updateType) {
      case 'RecordingStarting':
      case 'RecordingStarted':
      case 'RecordingStopping':
      case 'RecordingStopped':
      case 'RecordingPaused':
      case 'RecordingResumed':
        return RecordingStateEvent.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [SceneItemEvent] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  @deprecated
  SceneItemEvent asSceneItemEvent() {
    switch (updateType) {
      case 'SceneItemAdded':
      case 'SceneItemRemoved':
      case 'SceneItemSelected':
      case 'SceneItemDeselected':
        return SceneItemEvent.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [SceneItemStateEvent] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  @deprecated
  SceneItemStateEvent asSceneItemStateEvent() {
    switch (updateType) {
      case 'SceneItemVisibilityChanged':
      case 'SceneItemLockChanged':
        return SceneItemStateEvent.fromJson(rawEvent, updateType);
    }
    throw exception;
  }

  ///returns a [StreamStateEvent] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  @deprecated
  StreamStateEvent asSteamStateEvent() {
    switch (updateType) {
      case 'StreamStarting':
      case 'StreamStarted':
      case 'StreamStopping':
      case 'StreamStopped':
        return StreamStateEvent.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [StreamStatusEvent] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  @deprecated
  StreamStatusEvent asSteamStatusEvent() {
    if (updateType != 'StreamStatus') {
      throw exception;
    }
    return StreamStatusEvent.fromJson(rawEvent);
  }
}
