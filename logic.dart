// logic_weather.dart
import 'package:flutter/material.dart';

class LogicWeather {
  static String kToCelsius(double temp) {
    double celsius = temp - 273.15;
    return "${celsius.toStringAsFixed(1)}°C";
  }

  static dynamic iconchoser(String main) {
    switch (main.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny;
      case "thunderstorm":
        return Icons.thunderstorm;
      case "drizzle":
        return Icons.snowing;
      case "rain":
        return Icons.cloudy_snowing;
      case "snow":
        return Icons.ac_unit;
      case "clouds":
        return Icons.cloud;
      default:
        return Icons.help_outline;
    }
  }
}
