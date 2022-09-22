// function read json from file via http request

import 'dart:convert';

import 'package:dio/dio.dart';

class Utility {
  // read json from file via remote server
  static Future<String> loadJsonFromRemoteServer(String url) async {
    var dio = Dio();
    var response = await dio.get(url);
    return response.data;
  }

  // convert string to json
  static Map<String, dynamic> convertJsonStringToMap(String jsonString) {
    return json.decode(jsonString);
  }
}
