// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneItemStateEvent.dart';

// **************************************************************************
// EasyEnumGenerator
// **************************************************************************

extension SceneItemStateExt on SceneItemState {
  String get value =>
      ['sceneItemVisibilityChanged', 'sceneItemLockChanged'][index];
}

extension SceneItemStateTxe on String {
  SceneItemState? get sceneItemState => {
        'sceneItemVisibilityChanged': SceneItemState.sceneItemVisibilityChanged,
        'sceneItemLockChanged': SceneItemState.sceneItemLockChanged,
      }[this];
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemStateEvent _$SceneItemStateEventFromJson(Map<String, dynamic> json) {
  return SceneItemStateEvent(
    itemId: json['item-id'] as int,
    itemName: json['item-name'] as String,
    itemVisible: json['item-visible'] as bool?,
    itemLocked: json['item-locked'] as bool?,
    sceneName: json['scene-name'] as String,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$SceneItemStateEventToJson(
        SceneItemStateEvent instance) =>
    <String, dynamic>{
      'item-id': instance.itemId,
      'item-name': instance.itemName,
      'item-visible': instance.itemVisible,
      'item-locked': instance.itemLocked,
      'scene-name': instance.sceneName,
      'type': instance.type,
    };
