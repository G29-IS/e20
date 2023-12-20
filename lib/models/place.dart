import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Place {
  final String idPlace;
  final String name;
  final String adrAddress; // TODO: check if is a String or a List<String>
  final String url;

  const Place({
    required this.idPlace,
    required this.name,
    required this.adrAddress,
    required this.url,
  });

  Place copyWith({
    String? idPlace,
    String? name,
    String? adrAddress,
    String? url,
  }) {
    return Place(
      idPlace: idPlace ?? this.idPlace,
      name: name ?? this.name,
      adrAddress: adrAddress ?? this.adrAddress,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idPlace': idPlace});
    result.addAll({'name': name});
    result.addAll({'adrAddress': adrAddress});
    result.addAll({'url': url});

    return result;
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      idPlace: map['idPlace'] ?? '',
      name: map['name'] ?? '',
      adrAddress: map['adrAddress'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(idPlace: $idPlace, name: $name, adrAddress: $adrAddress, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.idPlace == idPlace &&
        other.name == name &&
        other.adrAddress == adrAddress &&
        other.url == url;
  }

  @override
  int get hashCode {
    return idPlace.hashCode ^ name.hashCode ^ adrAddress.hashCode ^ url.hashCode;
  }
}
