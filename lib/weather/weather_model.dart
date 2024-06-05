import 'package:flutter/material.dart';
import 'weather_service.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;
  final List<Forecast> forecast;
  final int airQualityIndex;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.forecast,
    required this.airQualityIndex,
  });
}

class Forecast {
  final String day;
  final double temperature;
  final String description;
  final String icon;

  Forecast({
    required this.day,
    required this.temperature,
    required this.description,
    required this.icon,
  });
}

class WeatherModel extends ChangeNotifier {
  Weather? weather;
  bool isLoading = false;

  Future<void> fetchWeather(String location) async {
    isLoading = true;
    notifyListeners();
    weather = await WeatherService.fetchCurrentWeather(location);
    isLoading = false;
    notifyListeners();
  }
}
