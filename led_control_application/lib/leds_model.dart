// To parse this JSON data, do
//
//     final leds = ledsFromJson(jsonString);

import 'dart:convert';

Leds ledsFromJson(String str) => Leds.fromJson(json.decode(str));

String ledsToJson(Leds data) => json.encode(data.toJson());

class Leds {
  Leds({
    required this.redValue,
    required this.greenValue,
    required this.blueValue,
    required this.br,
    required this.prog,
  });

  int redValue;
  int greenValue;
  int blueValue;
  int br;
  int prog;

  factory Leds.fromJson(Map<String, dynamic> json) => Leds(
    redValue: json["redValue"],
    greenValue: json["greenValue"],
    blueValue: json["blueValue"],
    br:json["brightness"],
    prog: json["prog"],
  );

  Map<String, dynamic> toJson() => {
    "redValue": redValue,
    "greenValue": greenValue,
    "blueValue": blueValue,
    "brightness": br,
    "prog": prog,
  };
}
