import 'package:flutter/material.dart';

/// A card that displays the current weather.
class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
  });

  // TODO: Wait?! Hier fehlt doch noch was 🧐

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
              // TODO: Display the correct weather icon
              // Use the .icon getter from Weather.type
              Icons.sunny,
              size: Theme.of(context).textTheme.displayLarge!.fontSize! * 2,
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // TODO: Display the correct temperature
                  "30 °C",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(width: 16),
                Text(
                  // TODO: Display the correct city
                  "Stuttgart",
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
