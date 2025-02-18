import 'dart:convert';
import 'dart:io';
import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'b571b2c26a30550e38a048efce0540e4';
  final String  baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String baseUrlFind = 'https://api.openweathermap.org/data/2.5/find';

   Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<List<String>> fetchCitySuggestions(String query) async {
    // If the query is empty, return an empty list
    if (query.isEmpty) {
      return [];
    }

    try {
      final url = Uri.parse('$baseUrlFind?q=$query&appid=$apiKey&limit=5');  // Limit to 5 suggestions
      final response = await http.get(url);

      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the city names from the response
        List<String> suggestions = [];
        for (var city in data['list']) {
          suggestions.add(city['name']);  // Add city name to suggestions list
        }

        return suggestions;
      } else {
        throw Exception('Failed to load city suggestions');
      }
    } catch (e) {
      print("Error fetching city suggestions: $e");
      return [];
    }
  }

  Future<Map<String, double>?> getCityCoordinates(String city) async {
    if (!await checkInternetConnection()) {
      print("No internet connection");
      return null;
    }

    try {
      String url = '$baseUrl?q=$city&appid=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double lat = data['coord']['lat'];
        double lon = data['coord']['lon'];
        return {'lat': lat, 'lon': lon};
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching city coordinates: $e');
      return null;
    }
  }

  Future<WeatherModel?> getWeather(double lat, double long) async {
    if(!await checkInternetConnection()){
      print("No internet connection");
      return null;
    }

    try {
      String url = '$baseUrl?lat=$lat&lon=$long&appid=$apiKey&units=metric';
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