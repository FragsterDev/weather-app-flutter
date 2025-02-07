// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 10,),
            Searchbar(),
            SizedBox(height: 35),
            Weatherimage(),
            SizedBox(height: 30),
            City(),
            TemperatureDisplay(),
            MidInfo(),
            SizedBox(height: 16,),
            BottomInfo(),
          ],
                ),
        ),),
    );
  }
}