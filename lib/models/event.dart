// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Event {
  final String id;
  final String name;
  final DateTime date;
  Event({
    required this.id,
    required this.name,
    required this.date,
  });

  Event copyWith({
    String? id,
    String? name,
    DateTime? date,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Event(id: $id, name: $name, date: $date)';

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ date.hashCode;
}
