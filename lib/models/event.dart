import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import 'enums.dart';

@immutable
class Event {
  final String idEvent;
  final String name;
  final String coverImageUrl;
  final String idOrganizer;
  final String description;
  final String? placeName;
  final String placeAddress;
  final DateTime doorOpeningDateTime;
  final DateTime openingDateTime;
  final EventType type;
  final int? maxPartecipants;
  final EventVisibility visibility;
  final String? paymentLink;
  final EventAvailability availability;
  final bool isModified;

  const Event({
    required this.idEvent,
    required this.name,
    required this.coverImageUrl,
    required this.idOrganizer,
    required this.description,
    this.placeName,
    required this.placeAddress,
    required this.doorOpeningDateTime,
    required this.openingDateTime,
    required this.type,
    this.maxPartecipants,
    required this.visibility,
    this.paymentLink,
    required this.availability,
    this.isModified = false,
  });

  Event copyWith({
    String? idEvent,
    String? name,
    String? coverImageUrl,
    String? idOrganizer,
    String? description,
    String? placeName,
    String? placeAddress,
    DateTime? doorOpeningDateTime,
    DateTime? openingDateTime,
    EventType? type,
    int? maxPartecipants,
    EventVisibility? visibility,
    String? paymentLink,
    EventAvailability? availability,
    bool? isModified,
  }) {
    return Event(
      idEvent: idEvent ?? this.idEvent,
      name: name ?? this.name,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      idOrganizer: idOrganizer ?? this.idOrganizer,
      description: description ?? this.description,
      placeName: placeName ?? this.placeName,
      placeAddress: placeAddress ?? this.placeAddress,
      doorOpeningDateTime: doorOpeningDateTime ?? this.doorOpeningDateTime,
      openingDateTime: openingDateTime ?? this.openingDateTime,
      type: type ?? this.type,
      maxPartecipants: maxPartecipants ?? this.maxPartecipants,
      visibility: visibility ?? this.visibility,
      paymentLink: paymentLink ?? this.paymentLink,
      availability: availability ?? this.availability,
      isModified: isModified ?? this.isModified,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idEvent': idEvent});
    result.addAll({'name': name});
    result.addAll({'coverImageUrl': coverImageUrl});
    result.addAll({'idOrganizer': idOrganizer});
    result.addAll({'description': description});
    if (placeName != null) {
      result.addAll({'placeName': placeName});
    }
    result.addAll({'placeAddress': placeAddress});
    result.addAll({'doorOpeningDateTime': doorOpeningDateTime.toIso8601String()});
    result.addAll({'openingDateTime': openingDateTime.toIso8601String()});
    result.addAll({'type': type.name});
    if (maxPartecipants != null) {
      result.addAll({'maxPartecipants': maxPartecipants});
    }
    result.addAll({'visibility': visibility.name});
    if (paymentLink != null) {
      result.addAll({'paymentLink': paymentLink});
    }
    result.addAll({'availability': availability.name});
    result.addAll({'isModified': isModified});

    return result;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      idEvent: map['idEvent'] ?? '',
      name: map['name'] ?? '',
      coverImageUrl: map['coverImageUrl'] ?? '',
      idOrganizer: map['idOrganizer'] ?? '',
      description: map['description'] ?? '',
      placeName: map['placeName'],
      placeAddress: map['placeAddress'] ?? '',
      doorOpeningDateTime: DateTime.parse(map['doorOpeningDateTime']),
      openingDateTime: DateTime.parse(map['openingDateTime']),
      type: EventType.values.byName(map['type']),
      maxPartecipants: map['maxPartecipants']?.toInt(),
      visibility: EventVisibility.values.byName(map['visibility']),
      paymentLink: map['paymentLink'],
      availability: EventAvailability.values.byName(map['availability']),
      isModified: map['isModified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(idEvent: $idEvent, name: $name, coverImageUrl: $coverImageUrl, idOrganizer: $idOrganizer, description: $description, placeName: $placeName, placeAddress: $placeAddress, doorOpeningDateTime: $doorOpeningDateTime, openingDateTime: $openingDateTime, type: $type, maxPartecipants: $maxPartecipants, visibility: $visibility, paymentLink: $paymentLink, availability: $availability, isModified: $isModified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.idEvent == idEvent &&
        other.name == name &&
        other.coverImageUrl == coverImageUrl &&
        other.idOrganizer == idOrganizer &&
        other.description == description &&
        other.placeName == placeName &&
        other.placeAddress == placeAddress &&
        other.doorOpeningDateTime == doorOpeningDateTime &&
        other.openingDateTime == openingDateTime &&
        other.type == type &&
        other.maxPartecipants == maxPartecipants &&
        other.visibility == visibility &&
        other.paymentLink == paymentLink &&
        other.availability == availability &&
        other.isModified == isModified;
  }

  @override
  int get hashCode {
    return idEvent.hashCode ^
        name.hashCode ^
        coverImageUrl.hashCode ^
        idOrganizer.hashCode ^
        description.hashCode ^
        placeName.hashCode ^
        placeAddress.hashCode ^
        doorOpeningDateTime.hashCode ^
        openingDateTime.hashCode ^
        type.hashCode ^
        maxPartecipants.hashCode ^
        visibility.hashCode ^
        paymentLink.hashCode ^
        availability.hashCode ^
        isModified.hashCode;
  }
}
