// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final String apiKey = 'b571b2c26a30550e38a048efce0540e4';
  final String city = 'Siliguri';
  final String url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("✅ API Response: ${response.body}");
    } else {
      print("❌ Error: ${response.statusCode}");
    }
  } catch (e) {
    print("❌ Failed to connect: $e");
  }
}