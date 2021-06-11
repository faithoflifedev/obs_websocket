// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sceneItemEvent.dart';

// **************************************************************************
// EasyEnumGenerator
// **************************************************************************

extension SceneItemChangeExt on SceneItemChange {
  String get value => [
        'sceneItemAdded',
        'sceneItemRemoved',
        'sceneItemSelected',
        'sceneItemDeselected'
      ][index];
}

extension SceneItemChangeTxe on String {
  SceneItemChange? get sceneItemChange => {
        'sceneItemAdded': SceneItemChange.sceneItemAdded,
        'sceneItemRemoved': SceneItemChange.sceneItemRemoved,
        'sceneItemSelected': SceneItemChange.sceneItemSelected,
        'sceneItemDeselected': SceneItemChange.sceneItemDeselected,
      }[this];
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneItemEvent _$SceneItemEventFromJson(Map<String, dynamic> json) {
  return SceneItemEvent(
    itemId: json['item-id'] as int,
    itemName: json['item-name'] as String,
    sceneName: json['scene-name'] as String,
    type: _$enumDecodeNullable(_$SceneItemChangeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$SceneItemEventToJson(SceneItemEvent instance) =>
    <String, dynamic>{
      'item-id': instance.itemId,
      'item-name': instance.itemName,
      'scene-name': instance.sceneName,
      'type': _$SceneItemChangeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$SceneItemChangeEnumMap = {
  SceneItemChange.sceneItemAdded: 'sceneItemAdded',
  SceneItemChange.sceneItemRemoved: 'sceneItemRemoved',
  SceneItemChange.sceneItemSelected: 'sceneItemSelected',
  SceneItemChange.sceneItemDeselected: 'sceneItemDeselected',
};
