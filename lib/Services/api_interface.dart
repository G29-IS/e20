// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '/Utils/console_log.dart';
import '/Config/configs.dart';

//Using Dio
class RESTInterface {
  static Future<Map<dynamic, dynamic>> GET({
    required String path,
    Map<String, String>? headers,
  }) async {
    var api = Dio();
    //api.options.headers['Access-Control-Allow-Origin'] = '*';
    api.options.validateStatus = (status) => true;
    if (headers != null) {
      headers.forEach((key, value) {
        api.options.headers[key] = value;
      });
    }
    var httpReq = await api.get(
      API_URL + path,
    );
    return httpReq.data;
  }

  static Future<Map<dynamic, dynamic>> POST({
    required String path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    var api = Dio();
    api.options.validateStatus = (status) => true;
    if (headers != null) {
      headers.forEach((key, value) {
        api.options.headers[key] = value;
      });
    }
    logError('[POST]: ${jsonEncode(body)}');
    var r = await api.post(API_URL + path, data: jsonEncode(body));
    return r.data;
  }

  static Future<Map<dynamic, dynamic>> PUT({
    required String path,
    FormData? body,
    Map<String, String>? headers,
  }) async {
    var api = Dio();
    api.options.validateStatus = (status) => true;
    if (headers != null) {
      headers.forEach((key, value) {
        api.options.headers[key] = value;
      });
    }
    var r = await api.put(API_URL + path, data: body);
    return r.data;
  }

  static Future<String> PUT_RAW({
    required String url,
    required List<int> body,
    Map<String, String>? headers,
  }) async {
    var api = Dio();
    api.options.validateStatus = (status) => true;
    if (headers != null) {
      headers.forEach((key, value) {
        api.options.headers[key] = value;
      });
    }
    api.options.headers['Content-Type'] = 'image/png';
    var r = await api.put(
      url,
      data: Stream.fromIterable(body.map((byte) => [byte])),
      options: Options(
        headers: {
          HttpHeaders.contentLengthHeader: body.length, // set content-length
        },
      ),
    );
    return r.data;
  }

  static Future<Map<dynamic, dynamic>> DELETE({
    required String path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    var api = Dio();
    api.options.validateStatus = (status) => true;
    if (headers != null) {
      headers.forEach((key, value) {
        api.options.headers[key] = value;
      });
    }
    logError(body.toString());
    logError('[DELETE]: ${jsonEncode(body)}');
    var r = await api.delete(API_URL + path, data: jsonEncode(body));
    return r.data;
  }
}
