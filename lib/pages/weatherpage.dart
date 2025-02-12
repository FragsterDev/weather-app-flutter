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
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();
  WeatherModel? _weather;

  double? _latitude;
  double? _longitude;

  String _city = ""; //Default city

  @override
  void initState() {
    super.initState();
    _initialiseLocationAndFetchWeather();
  }

  Future<void> _initialiseLocationAndFetchWeather() async {
    // final weatherData = await _weatherService.getWeather(26.727100,88.395287);
    // setState(() {
    //   _weather = weatherData;
    // });
    try {
      Position? position = await _locationService.getCurrentLocation();
      if(position != null){
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
        _fetchWeather();
      } else {
        print('Could not get location');
      }
    } catch(e){
      print("Error: $e");
    }
  }

  Future<void> _fetchWeather() async {
    if(_latitude == null || _longitude == null){
      print("Waiting  for location...");
      return;
    }
    final weatherData = await _weatherService.getWeather(_latitude!, _longitude!);
    setState(() {
      _weather = weatherData;
    });
  }

   Future<void> _updateCity(String newCity) async {
    setState(() {
      _city = newCity;
      // _fetchWeather();
    });

    final coordinates = await _weatherService.getCityCoordinates(newCity);

    if(coordinates != null){
      setState(() {
        _latitude = coordinates['lat'];
        _longitude = coordinates['lon'];
      });

      _fetchWeather();
    } else {
      print('Could not fetch coordinates for the city');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: _weather == null ? const Center(child: CircularProgressIndicator(),) :
         SingleChildScrollView(
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
