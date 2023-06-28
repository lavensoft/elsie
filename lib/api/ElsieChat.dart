import "package:http/http.dart" as http;
import 'dart:convert';
import "package:elsie/config/Config.dart";

class ElsieChat {
  static prompt(message) async {
    var client = http.Client();

    try {
      http.Response res = await client.post(
        Uri.parse("${Config.API_HOST}/prompt"), 
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }, 
        body: jsonEncode({
          "message" : message,
          "myap_token" : Config.MYAP_TOKEN,
          "lms_token": Config.LMS_TOKEN
        })
      );

      return jsonDecode(res.body);
    } finally {
      client.close();
    }
  }
}