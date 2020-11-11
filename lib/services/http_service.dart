import 'dart:convert';

import 'package:home_automation_mini_project/models/pins.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final String url = "http://saketanand-62208.portmap.io:62208/pins/";

  static Future<List<Pins>> getPins() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((e) {
        return Pins.fromJson(e);
      }).toList();
    }
  }

  static Future<bool> updateState(String id, String state) async {
    print("State:$state");
    var body = jsonEncode({"state": state});
    try {
      http.Response response = await http.patch("$url$id",
          body: body, headers: {"Content-type": "application/json"});
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
