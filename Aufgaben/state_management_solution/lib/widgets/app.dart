import 'package:flutter/material.dart';
import 'package:state_management/data/api.dart';
import 'package:state_management/widgets/animated_background_image.dart';
import 'package:state_management/widgets/weather_card.dart';

import '../models/weather.dart';
import 'geo_location_search_bar.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Future<Weather>? _weather;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBackgroundImage(
              image: _weather
                  ?.then((weather) => AssetImage(weather.type.backgroundImage)),
            ),
            Align(
              // Centered & Top - 10% Viewport
              alignment: const Alignment(0.0, -0.9),
              child: GeoLocationSearchBar(onLocationSelected: (location) {
                setState(() {
                  _weather = location != null ? Api.getWeather(location) : null;
                });
              }),
            ),
            Center(
              child: FutureBuilder(
                future: _weather,
                builder: (context, snapshot) =>
                    switch (snapshot.connectionState) {
                  // Loading
                  ConnectionState.waiting => const Card(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  // Data has loaded
                  ConnectionState.done => WeatherCard(
                      weather: snapshot.requireData,
                    ),
                  // No Future or Error
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}