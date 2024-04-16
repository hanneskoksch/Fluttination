import 'package:flutter/material.dart';

import 'geo_location_search_bar.dart';
import 'weather_card.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: const Stack(
          children: [
            Align(
              // Centered & Top - 10% Viewport
              alignment: Alignment(0.0, -0.9),
              child: GeoLocationSearchBar(),
            ),
            Center(
              child: WeatherCard(),
            ),
          ],
        ),
      ),
    );
  }
}
