// // import 'package:intl/intl.dart';

// // class WeatherModel {
// //   final String cityName;
// //   final double temperature;
// //   final String weatherCondition;
// //   final double humidity;
// //   final double windSpeed;
// //   final double pressure;
// //   final String time;
// //   final double uvIndex;
// //   final double rainChance;
// //   final int aqi;

// //   WeatherModel({
// //     required this.cityName,
// //     required this.temperature,
// //     required this.weatherCondition,
// //     required this.humidity,
// //     required this.windSpeed,
// //     required this.pressure,
// //     required this.time,
// //     required this.uvIndex,
// //     required this.rainChance,
// //     required this.aqi,
// //   });

// //    factory WeatherModel.fromJson(Map<String, dynamic> json) {
// //     return WeatherModel(
// //       cityName: json['name'],
// //       temperature: json['main']['temp'].toDouble(),
// //       weatherCondition: json['weather'][0]['main'],
// //       humidity: json['main']['humidity'].toDouble(),
// //       windSpeed: json['wind']['speed'].toDouble(),
// //       pressure: json['main']['pressure'].toDouble(),
// //       time: DateFormat('hh:mm a').format(
// //         DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000),
// //       ), // Formats timestamp into `11:25 AM`
// //       uvIndex: json['current']['uvi'].toDouble(),
// //       rainChance: json['current'].containsKey('rain') ? json['current']['rain']['1h'].toDouble() : 0.0,
// //       aqi: json.containsKey('aqi') ? json['aqi'] : 0, // AQI handling
// //     );
// //   }
// // }

// import 'package:intl/intl.dart';

// class WeatherModel {
//   final String cityName;
//   final double temperature;
//   final String weatherCondition;
//   final double humidity;
//   final double windSpeed;
//   final double pressure;
//   final String time;
//   final double uvIndex;
//   final double rainChance;
//   final int aqi;
//   final String sunrise;
//   final String sunset;
//   final String windDirection;

//   WeatherModel({
//     required this.cityName,
//     required this.temperature,
//     required this.weatherCondition,
//     required this.humidity,
//     required this.windSpeed,
//     required this.pressure,
//     required this.time,
//     required this.uvIndex,
//     required this.rainChance,
//     required this.aqi,
//     required this.sunrise,
//     required this.sunset,
//     required this.windDirection,
//   });

//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(
//       cityName: json['name'] ?? "Unknown", // ✅ Fix city name extraction
//       temperature: json['current']['temp'].toDouble(),
//       weatherCondition: json['current']['weather'][0]['main'],
//       humidity: json['current']['humidity'].toDouble(),
//       windSpeed: json['current']['wind_speed'].toDouble(),
//       pressure: json['current']['pressure'].toDouble(),
//       time: DateFormat('hh:mm a').format(
//         DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000),
//       ),
//       uvIndex: json['current']['uvi'].toDouble(),
//       rainChance: json['current'].containsKey('rain') ? json['current']['rain']['1h'].toDouble() : 0.0,
//       aqi: json.containsKey('aqi') ? json['aqi'] : 0, // ⚠️ Note: OpenWeather One Call API does NOT return AQI!
//       sunrise: DateFormat('hh:mm a').format(
//         DateTime.fromMillisecondsSinceEpoch(json['current']['sunrise'] * 1000),
//       ),
//       sunset: DateFormat('hh:mm a').format(
//         DateTime.fromMillisecondsSinceEpoch(json['current']['sunset'] * 1000),
//       ),
//       windDirection: _getWindDirection(json['current']['wind_deg']),
//     );
//   }

//   // Converts wind degrees to a compass direction (N, NE, E, SE, etc.)
//   static String _getWindDirection(int degrees) {
//     if (degrees >= 337 || degrees < 23) return "N";
//     if (degrees >= 23 && degrees < 68) return "NE";
//     if (degrees >= 68 && degrees < 113) return "E";
//     if (degrees >= 113 && degrees < 158) return "SE";
//     if (degrees >= 158 && degrees < 203) return "S";
//     if (degrees >= 203 && degrees < 248) return "SW";
//     if (degrees >= 248 && degrees < 293) return "W";
//     if (degrees >= 293 && degrees < 337) return "NW";
//     return "N"; // Default
//   }
// }


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
