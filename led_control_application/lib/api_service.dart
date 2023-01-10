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
    return null;
  }
    Future<Leds?> getLeds2() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl2 + ApiConstants.ledsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Leds _model = ledsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
    Future<Leds?> getLeds3() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl3 + ApiConstants.ledsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Leds _model = ledsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
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

    Future<http.Response> postLeds2 (int red, int green, int blue, int br, int prog) async{
    return http.post(
        Uri.parse(ApiConstants.baseUrl2 + ApiConstants.ledsEndpoint),
    body: jsonEncode({
      'redValue' : red,
      'greenValue' : green,
      'blueValue' : blue,
      'brightness': br,
      'prog' : prog
    }));
  }
      Future<http.Response> postLeds3 (int red, int green, int blue, int br, int prog) async{
    return http.post(
        Uri.parse(ApiConstants.baseUrl3 + ApiConstants.ledsEndpoint),
    body: jsonEncode({
      'redValue' : red,
      'greenValue' : green,
      'blueValue' : blue,
      'brightness': br,
      'prog' : prog
    }));
  }
}