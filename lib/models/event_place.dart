import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class EventPlace {
  final String address;
  final String? name;
  final String? url;

  const EventPlace({
    required this.address,
    this.name,
    this.url,
  });

  EventPlace copyWith({
    String? address,
    String? name,
    String? url,
  }) {
    return EventPlace(
      address: address ?? this.address,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'address': address});
    if (name != null) {
      result.addAll({'name': name});
    }
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory EventPlace.fromMap(Map<String, dynamic> map) {
    return EventPlace(
      address: map['address'] ?? 'Address is missing',
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventPlace.fromJson(String source) => EventPlace.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventPlace && other.address == address && other.name == name && other.url == url;
  }

  @override
  int get hashCode {
    return address.hashCode ^ name.hashCode ^ url.hashCode;
  }
}
