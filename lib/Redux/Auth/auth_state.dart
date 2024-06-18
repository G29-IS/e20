import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '/Models/enums.dart';
import '/Models/user.dart';

@immutable
class AuthState {
  ///
  /// DATA

  /// JWT token for authentication
  final String? authToken;

  /// Currently authenticated users, null if not authenticated
  final User? currentUser;

  ///
  /// STATE

  /// Loading status of the authentication process
  final LoadingStatus authLoadingStatus;

  const AuthState({
    required this.authToken,
    required this.currentUser,
    required this.authLoadingStatus,
  });

  factory AuthState.initial() {
    return const AuthState(
      // authToken: null,
      authToken: null,
      currentUser: null,
      authLoadingStatus: LoadingStatus.none,
    );
  }

  AuthState copyWith({
    String? authToken,
    User? currentUser,
    LoadingStatus? authLoadingStatus,
  }) {
    return AuthState(
      authToken: authToken ?? this.authToken,
      currentUser: currentUser ?? this.currentUser,
      authLoadingStatus: authLoadingStatus ?? this.authLoadingStatus,
    );
  }

  AuthState copyWithNullStrict({
    String? authToken,
    User? currentUser,
    LoadingStatus? authLoadingStatus,
  }) {
    return AuthState(
      authToken: authToken,
      currentUser: currentUser,
      authLoadingStatus: authLoadingStatus ?? this.authLoadingStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authToken': authToken,
      'currentUser': currentUser?.toJson(),
      'authLoadingStatus': authLoadingStatus.name,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      authToken: map['authToken'],
      currentUser: map['currentUser'],
      authLoadingStatus: LoadingStatus.values.byName(map['authLoadingStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) => AuthState.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthStat(authToken: $authToken, currentUserL $currentUser, authLoadingStatus: $authLoadingStatus)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.authToken == authToken &&
        other.currentUser == currentUser &&
        other.authLoadingStatus == authLoadingStatus;
  }

  @override
  int get hashCode => authToken.hashCode ^ currentUser.hashCode ^ authLoadingStatus.hashCode;
}
