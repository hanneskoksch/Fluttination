import 'package:flutter/material.dart';
import 'package:routing/widgets/app.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
    usePathUrlStrategy();
  runApp(const WeatherApp());
}
