import 'package:weather/weather.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final double humidity;
  final double windSpeed;
  final double pressure;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory WeatherModel.fromWeather(Weather w) {
    return WeatherModel(
      cityName: w.areaName ?? "Unknown",
      temperature: w.temperature?.celsius ?? 0.0, // Ensure a double value
      weatherCondition: w.weatherMain ?? "Unknown",
      humidity: w.humidity ?? 0,
      windSpeed: w.windSpeed ?? 0.0,
      pressure: w.pressure ?? 0,
    );
  }
}
