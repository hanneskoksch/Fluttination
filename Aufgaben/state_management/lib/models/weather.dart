import 'package:flutter/material.dart';

class Weather {
  Weather({required this.temperature, required this.type, required this.city});

  final double temperature;
  final WeatherType type;
  final String city;

  factory Weather.fromJson({required Map<String, dynamic> json}) {
    return Weather(
      temperature: json["main"]["temp"],
      type: WeatherType.fromCode(code: json["weather"][0]["id"]),
      city: json["name"] ?? "",
    );
  }
}

enum WeatherType {
  thunderstorm,
  rain,
  snow,
  mist,
  clear,
  clouds,
  unknown;

  static WeatherType fromCode({required int code}) {
    final String group = "$code"[0];

    if (group == "2") {
      return WeatherType.thunderstorm;
    } else if (["3", "5"].contains(group)) {
      return WeatherType.rain;
    } else if (group == "6") {
      return WeatherType.snow;
    } else if (group == "7") {
      return WeatherType.mist;
    } else if (group == "8") {
      if (code == 800) {
        return WeatherType.clear;
      } else {
        return WeatherType.clouds;
      }
    }

    return WeatherType.unknown;
  }

  IconData get icon => switch (this) {
        WeatherType.thunderstorm => Icons.thunderstorm,
        WeatherType.rain => Icons.water_drop,
        WeatherType.snow => Icons.snowing,
        WeatherType.mist => Icons.foggy,
        WeatherType.clear => Icons.sunny,
        WeatherType.clouds => Icons.cloud,
        WeatherType.unknown => Icons.question_mark,
      };

  static get _baseBackgroundImagePath => "images/backgrounds";
  String get backgroundImage => switch (this) {
        WeatherType.thunderstorm =>
          "$_baseBackgroundImagePath/thunderstorm.jpeg",
        WeatherType.rain => "$_baseBackgroundImagePath/rain.jpeg",
        WeatherType.snow => "$_baseBackgroundImagePath/snow.jpeg",
        WeatherType.mist => "$_baseBackgroundImagePath/mist.jpeg",
        WeatherType.clear => "$_baseBackgroundImagePath/clear.jpeg",
        WeatherType.clouds => "$_baseBackgroundImagePath/clouds.jpeg",
        _ => "$_baseBackgroundImagePath/clear.jpeg",
      };
}
