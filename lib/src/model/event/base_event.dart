import 'dart:convert';

abstract class BaseEvent {
  Map<String, dynamic> toJson();

  @override
  String toString() => json.encode(toJson());
}
