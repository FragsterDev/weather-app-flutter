// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../services/weather_service.dart';
import 'package:weather_app/widgets/temparature_display.dart';
import '../widgets/searchbar.dart';
import '../widgets/weatherimage.dart';
import '../widgets/cityshow.dart';
import '../widgets/midinfo.dart';
import '../widgets/bottominfo.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;

  String _city = ""; //Default city

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weatherData = await _weatherService.getWeather(_city);
    setState(() {
      _weather = weatherData;
    });
  }

  void _updateCity(String newCity) {
    setState(() {
      _city = newCity;
      _fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Searchbar(onCityChanged: _updateCity),
              SizedBox(height: 35),
              Weatherimage(condition: _weather?.weatherCondition ?? "Clear"),
              SizedBox(height: 30),
              City(cityName: _weather?.cityName ?? "---"),
              TemperatureDisplay(
                temp: _weather?.temperature ?? 0,
                feels: _weather?.temperature ?? 0,
              ),
              MidInfo(
                time: _weather?.time ?? "--:--",
                high: _weather?.high ?? 0.0,
                low: _weather?.low ?? 0.0,
                rainChance: _weather?.humidity ?? 0.0,
                visibility: _weather?.visibility ?? 0.0,
                condition: _weather?.condition ?? 'unknown',
              ),
              SizedBox(
                height: 16,
              ),
              BottomInfo(
                sunriseTime: _weather?.sunrise ?? "--:--",
                sunsetTime: _weather?.sunset ?? "--:--",
                windSpeed: _weather?.windSpeed ?? 0.0,
                windDirection: _weather?.windDirection ?? "N",
                pressure: _weather?.pressure ?? 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
