import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '/Models/enums.dart';

@immutable
class User {
  final String idUser;
  final String name;
  final String surname;
  final String username;
  final String email;
  final String? passwordHash;
  final String phone;
  final DateTime birthDate;
  final Gender gender;
  // final CityOfInterest cityOfInterest; // TODO: on D3, CityOfInterest is not specified.
  final String profileImageUrl;

  const User({
    required this.idUser,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    this.passwordHash,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.profileImageUrl,
  });

  static empty() {
    return User(
      idUser: '',
      name: '',
      surname: '',
      username: '',
      email: '',
      passwordHash: '',
      phone: '',
      gender: Gender.other,
      profileImageUrl: '',
      birthDate: DateTime.now(),
    );
  }

  User copyWith({
    String? idUser,
    String? name,
    String? surname,
    String? username,
    String? email,
    String? passwordHash,
    String? phone,
    DateTime? birthDate,
    Gender? gender,
    String? profileImageUrl,
  }) {
    return User(
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'idUser': idUser});
    result.addAll({'name': name});
    result.addAll({'surname': surname});
    result.addAll({'username': username});
    result.addAll({'email': email});
    if (passwordHash != null) {
      result.addAll({'passwordHash': passwordHash});
    }
    result.addAll({'phone': phone});
    result.addAll({'birthDate': birthDate.millisecondsSinceEpoch});
    result.addAll({'gender': gender.name});
    result.addAll({'profileImageUrl': profileImageUrl});
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      idUser: map['idUser'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      passwordHash: map['passwordHash'],
      phone: map['phone'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      gender: Gender.values.byName(map['gender'].toString().toLowerCase()),
      profileImageUrl: map['profileImageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(idUser: $idUser, name: $name, surname: $surname, username: $username, email: $email, passwordHash: $passwordHash, phone: $phone, birthDate: $birthDate, gender: $gender, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.idUser == idUser &&
        other.name == name &&
        other.surname == surname &&
        other.username == username &&
        other.email == email &&
        other.passwordHash == passwordHash &&
        other.phone == phone &&
        other.birthDate == birthDate &&
        other.gender == gender &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        username.hashCode ^
        email.hashCode ^
        passwordHash.hashCode ^
        phone.hashCode ^
        birthDate.hashCode ^
        gender.hashCode ^
        profileImageUrl.hashCode;
  }
}
