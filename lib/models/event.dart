// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Event {
  final string id;
  final string name;
  final DateTime date;
  Event({
    required this.id,
    required this.name,
    required this.date,
  });

  Event copyWith({
    string? id,
    string? name,
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
      'id': id.toMap(),
      'name': name.toMap(),
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: string.fromMap(map['id'] as Map<String,dynamic>),
      name: string.fromMap(map['name'] as Map<String,dynamic>),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Event(id: $id, name: $name, date: $date)';

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ date.hashCode;
}
