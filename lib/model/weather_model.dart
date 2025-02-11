import 'package:intl/intl.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final String time;
  final String sunrise;
  final String sunset;
  final String windDirection;
  final double high;
  final double low;
  final String condition;
  final double visibility;
  final double feelsLike;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.time,
    required this.sunrise,
    required this.sunset,
    required this.windDirection,
    required this.high,
    required this.low,
    required this.feelsLike,
    required this.condition,
    required this.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? "Unknown",
      temperature: json['main']?['temp']?.toDouble() ?? 0.0, // ✅ Corrected key
      weatherCondition: json['weather']?[0]?['main'] ?? "Unknown", // ✅ Corrected key
      humidity: json['main']?['humidity']?.toDouble() ?? 0.0, // ✅ Corrected key
      windSpeed: json['wind']?['speed']?.toDouble() ?? 0.0, // ✅ Corrected key
      pressure: json['main']?['pressure']?.toDouble() ?? 0.0, // ✅ Corrected key
      time: json['dt'] != null
          ? DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
            )
          : "--:--",
      sunrise: json['sys']?['sunrise'] != null
          ? DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
            )
          : "--:--",
      sunset: json['sys']?['sunset'] != null
          ? DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
            )
          : "--:--",
      windDirection: _getWindDirection(json['wind']?['deg'] ?? 0), // ✅ Corrected key
      high: json['main']?['temp_max']?.toDouble() ?? 0.0,
      low: json['main']?['temp_min']?.toDouble() ?? 0.0,
      feelsLike: json['main']?['feels_like']?.toDouble() ?? 0.0,
      visibility: json['visibility']?.toDouble() ?? 0.0,
      condition: json['weather']?[0]['main'] ?? 'unknown',
    );
  }

  // Converts wind degrees to a compass direction (N, NE, E, SE, etc.)
  static String _getWindDirection(int degrees) {
    if (degrees >= 337 || degrees < 23) return "N";
    if (degrees >= 23 && degrees < 68) return "NE";
    if (degrees >= 68 && degrees < 113) return "E";
    if (degrees >= 113 && degrees < 158) return "SE";
    if (degrees >= 158 && degrees < 203) return "S";
    if (degrees >= 203 && degrees < 248) return "SW";
    if (degrees >= 248 && degrees < 293) return "W";
    if (degrees >= 293 && degrees < 337) return "NW";
    return "N"; // Default
  }
}
