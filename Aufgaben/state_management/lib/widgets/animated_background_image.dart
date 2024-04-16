import 'package:flutter/material.dart';
import 'package:state_management/models/weather.dart';

class AnimatedBackgroundImage extends StatefulWidget {
  const AnimatedBackgroundImage({
    super.key,
    required this.weather,
    this.duration = const Duration(seconds: 1),
  });

  final Future<Weather>? weather;
  final Duration duration;

  @override
  State<AnimatedBackgroundImage> createState() =>
      _AnimatedBackgroundImageState();
}

class _AnimatedBackgroundImageState extends State<AnimatedBackgroundImage> {
  String? _asset;

  @override
  void initState() {
    super.initState();
    // Update the background image as soon as its loaded
    if (widget.weather != null) {
      widget.weather!.then(
        (weather) => setState(() => _asset = weather.type.backgroundImage),
      );
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedBackgroundImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.weather == null) {
      // If the new weather future is null, clear the image
      _asset = null;
    } else {
      // Wait for the image to load and ...
      widget.weather!.then((weather) {
        // ... if the image is different ...
        if (weather.type.backgroundImage != _asset) {
          setState(() {
            // ... update the Image
            _asset = weather.type.backgroundImage;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      child: _asset != null
          ? SizedBox.expand(
              key: ValueKey(_asset),
              child: Image.asset(_asset!, fit: BoxFit.cover),
            )
          : null,
    );
  }
}
