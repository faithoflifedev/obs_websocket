import 'package:obs_websocket/src/model/event/recordingState.dart';
import 'package:obs_websocket/src/model/event/sceneItem.dart';
import 'package:obs_websocket/src/model/event/sceneItemState.dart';
import 'package:obs_websocket/src/model/event/streamState.dart';
import 'package:obs_websocket/src/model/event/streamStatus.dart';

class BaseEvent {
  final String updateType;
  final Map<String, dynamic> rawEvent;

  static final Exception exception = Exception('Wrong event type');

  BaseEvent(this.updateType, this.rawEvent);

  factory BaseEvent.fromJson(Map<String, dynamic> json) {
    return BaseEvent(json['update-type'], json);
  }

  ///returns a [RecordingState] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  RecordingState asRecordingStateEvent() {
    switch (updateType) {
      case 'RecordingStarting':
      case 'RecordingStarted':
      case 'RecordingStopping':
      case 'RecordingStopped':
      case 'RecordingPaused':
      case 'RecordingResumed':
        return RecordingState.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [SceneItem] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  SceneItem asSceneItemEvent() {
    switch (updateType) {
      case 'SceneItemAdded':
      case 'SceneItemRemoved':
      case 'SceneItemSelected':
      case 'SceneItemDeselected':
        return SceneItem.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [SceneItemState] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  SceneItemState asSceneItemStateEvent() {
    switch (updateType) {
      case 'SceneItemVisibilityChanged':
      case 'SceneItemLockChanged':
        return SceneItemState.fromJson(rawEvent, updateType);
    }
    throw exception;
  }

  ///returns a [StreamState] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  StreamState asSteamStateEvent() {
    switch (updateType) {
      case 'StreamStarting':
      case 'StreamStarted':
      case 'StreamStopping':
      case 'StreamStopped':
        return StreamState.fromJson(rawEvent, updateType);
    }

    throw exception;
  }

  ///returns a [StreamStatus] object or an [Exception] if [BaseEvent] type
  ///can't be resolved.
  StreamStatus asSteamStatusEvent() {
    if (updateType != 'StreamStatus') {
      throw exception;
    }
    return StreamStatus.fromJson(rawEvent);
  }
}
