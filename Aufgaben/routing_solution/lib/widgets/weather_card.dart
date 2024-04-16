import 'package:flutter/material.dart';

import '../models/weather.dart';

/// A card that displays the current weather.
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(.40),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              weather.type.icon,
              size: Theme.of(context).textTheme.displayLarge!.fontSize! * 2,
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${weather.temperature} °C",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(width: 16),
                Text(
                  weather.city,
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
