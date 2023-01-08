import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:led_control_application/constants.dart';
import 'package:led_control_application/leds_model.dart';

class ApiService {
  Future<Leds?> getLeds() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.ledsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Leds _model = ledsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<http.Response> postLeds (int red, int green, int blue, int br, int prog) async{
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.ledsEndpoint),
    body: jsonEncode({
      'redValue' : red,
      'greenValue' : green,
      'blueValue' : blue,
      'brightness': br,
      'prog' : prog
    }));
  }
}