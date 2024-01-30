import 'package:flutter/foundation.dart' show ErrorDescription;

import '/Services/api_interface.dart';

class RequestHandler {
  ///
  ///
  /// EVENTS STATE

  static Future<Map<String, dynamic>> fetchFeed(String? token) async {
    if (token == null) {
      throw ArgumentError.value(token, 'Null token');
    } else {
      var response = await RESTInterface.GET(
        path: '/feed',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response['status'] == 200 && response['msg'].length > 0) {
        return response['msg'];
      } else {
        throw ErrorDescription('fetchFeed error: status code is ${response['status']}');
      }
    }
  }
}
