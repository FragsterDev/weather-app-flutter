import 'dart:convert';
import 'dart:io';
import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'b571b2c26a30550e38a048efce0540e4';
  final String  baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

   Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<WeatherModel?> getWeather(String city) async {
    if(!await checkInternetConnection()){
      print("No internet connection");
      return null;
    }

    try {
      String url = '$baseUrl?q=$city&appid=$apiKey&units=metric';
      print(url);
      final response = await http.get(
        Uri.parse(url),
      );
      print("📥 Response Status: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        return null;
      }
    }
    catch(e){
      print('Error fetching weather: $e');
      return null;
    }
  }
}