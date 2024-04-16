import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_management/models/geo_location.dart';
import 'package:state_management/models/weather.dart';

abstract class Api {
  // TODO: Replace with our API Key
  static const String _geoLocationsApiKey = "";

  // TODO: Replace with our API Key
  static const String _weatherApiKey = "";

  static Future<Weather> getWeather(GeoLocation location) async {
    // TODO: Implement this!
    throw UnimplementedError();
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
