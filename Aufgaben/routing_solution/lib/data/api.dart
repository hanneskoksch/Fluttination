import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:routing/models/geo_location.dart';
import 'package:routing/models/weather.dart';

abstract class Api {
// TODO: Replace with our API Key
  static const String _geoLocationsApiKey = "";

// TODO: Replace with our API Key
  static const String _weatherApiKey = "";

  static Future<Weather> getWeather(GeoLocation location) async {
    final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$_weatherApiKey",
    ));

    switch (response.statusCode) {
      case 200:
        break;
      default:
        throw Exception(
          "Getting Weather for $location failed. Response Code: ${response.statusCode}",
        );
    }

    try {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json: json);
    } catch (e) {
      throw Exception("Failed to decode response body; ${response.body}");
    }
  }

  static Future<Weather> getWeatherWithCoordinates(
      double lat, double long) async {
    final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$_weatherApiKey",
    ));

    switch (response.statusCode) {
      case 200:
        break;
      default:
        throw Exception(
          "Getting Weather for location (lat: $lat long: $long) failed. Response Code: ${response.statusCode}",
        );
    }

    try {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json: json);
    } catch (e) {
      throw Exception("Failed to decode response body; ${response.body}");
    }
  }

  static Future<List<GeoLocation>> getGeoLocations(String address) async {
    final response = await http.get(Uri.parse(
      "https://us1.locationiq.com/v1/autocomplete?tag=place%3Acity%2Cplace%3Atown%2Cplace%3Avillage&limit=5&accept-language=de&dedupe=1&key=$_geoLocationsApiKey&q=$address",
    ));

    switch (response.statusCode) {
      case 200:
        break;
      case 404:
        return [];
      default:
        throw Exception(
          "Getting GeoLocation for '$address' failed. Response Code: ${response.statusCode}",
        );
    }

    try {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      if (json is! List) throw Exception("Invalid response body format.");

      return json.map((e) => GeoLocation.fromJson(json: e)).toList();
    } catch (e) {
      throw Exception("Failed to decode response body: ${response.body}");
    }
  }
}
