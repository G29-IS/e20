import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '/models/enums.dart';

@immutable
class Event {
  final String idEvent;
  final String name;
  final String coverImageUrl;
  final String description;
  // final Place place;
  final DateTime doorOpeningDateTime;
  final EventType type;
  final int? maxPartecipants;
  final EventVisibility visibility;
  final String paymentLink;
  final EventAvailability availability;
  final bool isModified;
  final DateTime timesShared;

  Event({
    required this.idEvent,
    required this.name,
    required this.coverImageUrl,
    required this.description,
    required this.doorOpeningDateTime,
    required this.type,
    this.maxPartecipants,
    required this.visibility,
    required this.paymentLink,
    required this.availability,
    required this.isModified,
    required this.timesShared,
  });

  Event copyWith({
    String? idEvent,
    String? name,
    String? coverImageUrl,
    String? description,
    DateTime? doorOpeningDateTime,
    EventType? type,
    int? maxPartecipants,
    EventVisibility? visibility,
    String? paymentLink,
    EventAvailability? availability,
    bool? isModified,
    DateTime? timesShared,
  }) {
    return Event(
      idEvent: idEvent ?? this.idEvent,
      name: name ?? this.name,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      description: description ?? this.description,
      doorOpeningDateTime: doorOpeningDateTime ?? this.doorOpeningDateTime,
      type: type ?? this.type,
      maxPartecipants: maxPartecipants ?? this.maxPartecipants,
      visibility: visibility ?? this.visibility,
      paymentLink: paymentLink ?? this.paymentLink,
      availability: availability ?? this.availability,
      isModified: isModified ?? this.isModified,
      timesShared: timesShared ?? this.timesShared,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idEvent': idEvent});
    result.addAll({'name': name});
    result.addAll({'coverImageUrl': coverImageUrl});
    result.addAll({'description': description});
    result.addAll({'doorOpeningDateTime': doorOpeningDateTime.millisecondsSinceEpoch});
    result.addAll({'type': type.name});
    if (maxPartecipants != null) {
      result.addAll({'maxPartecipants': maxPartecipants});
    }
    result.addAll({'visibility': visibility.name});
    result.addAll({'paymentLink': paymentLink});
    result.addAll({'availability': availability.name});
    result.addAll({'isModified': isModified});
    result.addAll({'timesShared': timesShared.millisecondsSinceEpoch});

    return result;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      idEvent: map['idEvent'] ?? '',
      name: map['name'] ?? '',
      coverImageUrl: map['coverImageUrl'] ?? '',
      description: map['description'] ?? '',
      doorOpeningDateTime: DateTime.fromMillisecondsSinceEpoch(map['doorOpeningDateTime']),
      type: EventType.values.byName(map['type']),
      maxPartecipants: map['maxPartecipants']?.toInt(),
      visibility: EventVisibility.values.byName(map['visibility']),
      paymentLink: map['paymentLink'] ?? '',
      availability: EventAvailability.values.byName(map['availability']),
      isModified: map['isModified'] ?? false,
      timesShared: DateTime.fromMillisecondsSinceEpoch(map['timesShared']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(idEvent: $idEvent, name: $name, coverImageUrl: $coverImageUrl, description: $description, doorOpeningDateTime: $doorOpeningDateTime, type: $type, maxPartecipants: $maxPartecipants, visibility: $visibility, paymentLink: $paymentLink, availability: $availability, isModified: $isModified, timesShared: $timesShared)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.idEvent == idEvent &&
        other.name == name &&
        other.coverImageUrl == coverImageUrl &&
        other.description == description &&
        other.doorOpeningDateTime == doorOpeningDateTime &&
        other.type == type &&
        other.maxPartecipants == maxPartecipants &&
        other.visibility == visibility &&
        other.paymentLink == paymentLink &&
        other.availability == availability &&
        other.isModified == isModified &&
        other.timesShared == timesShared;
  }

  @override
  int get hashCode {
    return idEvent.hashCode ^
        name.hashCode ^
        coverImageUrl.hashCode ^
        description.hashCode ^
        doorOpeningDateTime.hashCode ^
        type.hashCode ^
        maxPartecipants.hashCode ^
        visibility.hashCode ^
        paymentLink.hashCode ^
        availability.hashCode ^
        isModified.hashCode ^
        timesShared.hashCode;
  }
}
