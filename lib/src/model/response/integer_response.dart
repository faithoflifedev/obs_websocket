import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'integer_response.g.dart';

/// Maps to a integer response form the websocket.  `int?` fields are added to the class for each Response type needed.
@JsonSerializable()
class IntegerResponse {
  final int? sceneItemId;

  int get itemId => sceneItemId != null ? sceneItemId! : throw Exception();

  IntegerResponse({
    this.sceneItemId,
  });

  factory IntegerResponse.fromJson(Map<String, dynamic> json) =>
      _$IntegerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntegerResponseToJson(this);

  @override
  String toString() => json.encode(toJson());
}
