import 'dart:convert';

import 'package:flutter/foundation.dart' show ErrorDescription;

import '/Services/api_interface.dart';

class RequestHandler {
  ///
  ///
  /// EVENTS STATE

  static Future<List<dynamic>> fetchFeed() async {
    var response = await RESTInterface.GET(
      path: '/events',
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ErrorDescription('fetchFeed error: status code is ${response.data}');
    }
  }
}
