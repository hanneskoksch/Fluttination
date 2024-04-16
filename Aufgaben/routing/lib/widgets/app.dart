import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing/data/api.dart';
import 'package:routing/widgets/animated_background_image.dart';
import 'package:routing/widgets/weather_card.dart';

import '../models/weather.dart';
import 'geo_location_search_bar.dart';

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        double? lat = double.tryParse(state.uri.queryParameters["lat"] ?? "");
        double? long = double.tryParse(state.uri.queryParameters["long"] ?? "");
        return HomeScreen(
          lat: lat,
          long: long,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.lat, this.long});

  final double? lat;
  final double? long;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather>? _weather;

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lat != oldWidget.lat || widget.long != oldWidget.long) {
      getWeather();
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() {
    if (widget.lat != null && widget.long != null) {
      _weather = Api.getWeatherWithCoordinates(widget.lat!, widget.long!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (location != null) {
                context.go(
                    "/?lat=${location.latitude}&long=${location.longitude}");
              }
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
    );
  }
}
