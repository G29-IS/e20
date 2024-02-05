import 'package:flutter/foundation.dart' show ErrorDescription;

import '/Services/api_interface.dart';

class RequestHandler {
  ///
  ///
  /// EVENTS STATE

  static Future<Map<String, dynamic>> fetchFeed() async {
    var response = await RESTInterface.GET(
      path: '/events',
    );

    if (response['status'] == 200 && response['msg'].length > 0) {
      return response['msg'];
    } else {
      throw ErrorDescription('fetchFeed error: status code is ${response['status']}');
    }
  }
}
