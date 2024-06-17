import 'package:flutter/foundation.dart' show ErrorDescription;

import '/Models/event.dart';
import '/Models/user.dart';
import '/Services/api_interface.dart';
import '/Utils/console_log.dart';

class RequestHandler {
  ///
  ///
  /// AUTH STATE

  static Future<String> login(String email, String password) async {
    logWarning("[RH] Into login");
    var bodyRaw = <String, String>{'email': email, 'password': password};

    var response = await RESTInterface.POST(
      path: '/login',
      body: Map.of(bodyRaw),
    );

    if (response.statusCode == 200 && response.data != null) {
      logSuccess("[RH login]: ${response.data.toString()}");
      return response.data['token'];
    } else {
      throw ErrorDescription(
        '[RH ERROR login]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }

  static Future<String> loginWithGoogle(String idToken) async {
    logWarning("[RH] Into loginWithGoogle");

    var response = await RESTInterface.GET(
      path: '/login?tokenId=$idToken',
    );

    if (response.statusCode == 200 && response.data != null) {
      logSuccess("[RH loginWithGoogle]: ${response.data.toString()}");
      return response.data['token'];
    } else {
      throw ErrorDescription(
        '[RH ERROR loginWithGoogle]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }

  static Future<void> logout() async {
    logWarning("[RH] Into logout");

    var response = await RESTInterface.GET(
      path: '/logout',
    );

    if (response.statusCode != 200) {
      throw ErrorDescription(
        '[RH ERROR logout]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }

  static Future<void> passwordForgotten(String email) async {
    logWarning("[RH] Into password forgotten");

    var response = await RESTInterface.GET(
      path: '/password-forgotten?email=$email',
    );

    if (response.statusCode != 200) {
      throw ErrorDescription(
        '[RH ERROR logout]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }

  static Future<User> fetchCurrentUser(String? token) async {
    if (token == null) {
      throw ArgumentError.value(token, 'Null token');
    } else {
      logWarning("[RH] Into fetchCurrentUser");
      var response = await RESTInterface.GET(
        path: '/me',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 && response.data != null) {
        logSuccess("[RH fetchCurrentUser]: ${response.data.toString()}");
        return User.fromMap(response.data);
      } else {
        throw ErrorDescription(
          '[RH ERROR fetchCurrentUser]: status code: ${response.statusCode}. body: ${response.data}',
        );
      }
    }
  }

  ///
  ///
  /// USERS STATE

  static Future<Map<String, dynamic>> fetchUser({
    required String idUser,
  }) async {
    logWarning("[RH] Into fetchUser");
    var response = await RESTInterface.GET(
      path: '/users/$idUser',
    );

    if (response.statusCode == 200 && response.data != null) {
      logSuccess("[RH fetchUser]: ${response.data.toString()}");
      return response.data;
    } else {
      throw ErrorDescription(
        '[RH ERROR fetchUser]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }

  ///
  ///
  /// EVENTS STATE

  static Future<Map<String, dynamic>> fetchFeed() async {
    var response = await RESTInterface.GET(
      path: '/events',
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ErrorDescription('fetchFeed error: status code is ${response.data}');
    }
  }

  static Future<dynamic> createNewEvent(Event event, String token) async {
    logWarning("[RH] Post event");

    var response = await RESTInterface.POST(
      path: '/events',
      body: event.toMap(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 && response.data != null) {
      logSuccess("[RH create event]: created event - ${response.data.toString()}");
      return response.data;
    } else {
      throw ErrorDescription(
        '[RH ERROR create event]: status code: ${response.statusCode}. body: ${response.data}',
      );
    }
  }
}
