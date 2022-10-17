import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<Map<String, dynamic>?> get(apiUrl) async {
    var client = http.Client();
    try {
      Uri url = Uri.parse(apiUrl);

      Map<String, String> header = {
        "content-type": "application/json",
      };

      var response = await client.get(url, headers: header);
      int statusCode = response.statusCode;
      Map<String, dynamic> decodedResponse = json.decode(response.body);

      if(statusCode == 200 && decodedResponse.isNotEmpty){
        return decodedResponse;
      }

      return null;

    } catch(e){

      debugPrint(e.toString());
      return null;

    } finally {
      client.close();
    }
  }
}
