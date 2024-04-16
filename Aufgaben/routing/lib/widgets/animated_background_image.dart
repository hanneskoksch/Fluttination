import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBackgroundImage extends StatefulWidget {
  const AnimatedBackgroundImage({
    super.key,
    required this.image,
    this.blur = 2.5,
    this.duration = const Duration(seconds: 1),
  });

  final Future<ImageProvider>? image;
  final double blur;
  final Duration duration;

  @override
  State<AnimatedBackgroundImage> createState() =>
      _AnimatedWeatherBackgroundState();
}

class _AnimatedWeatherBackgroundState extends State<AnimatedBackgroundImage> {
  DecorationImage? _decoration;

  @override
  void didUpdateWidget(covariant AnimatedBackgroundImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If we previously had an image but it changed to null,
    // set the decoration image to null..
    if (oldWidget.image != null && widget.image == null) {
      _decoration = null;
      return;
    }

    // If we previously had an image and it changed
    // clear the decoration while the new one is loading...
    if (oldWidget.image != null && widget.image != null) {
      _decoration = null;
    }

    widget.image?.then(
      (image) => setState(() {
        _decoration = DecorationImage(
          image: image,
          fit: BoxFit.cover,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          image: _decoration,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
        ));
  }
}
