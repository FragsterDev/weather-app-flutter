import 'package:flutter/material.dart';

class Weatherimage extends StatelessWidget {
  final String condition; // ✅ Accepts the weather condition as a parameter
  final DateTime timeOfDay;

  const Weatherimage({Key? key, required this.condition, required this.timeOfDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath;

    bool isNight = timeOfDay.hour >=18 || timeOfDay.hour < 6;

    // ✅ Match weather conditions to images
    if(isNight && condition.toLowerCase() == 'clear'){
      imagePath = 'assets/icons/night.png';
    } else {

    switch (condition.toLowerCase()) {
      case 'clear':
        imagePath = 'assets/icons/Group.png';
        break;
      case 'clouds':
        imagePath = 'assets/icons/clouds.png';
        break;
      case 'rain':
        imagePath = 'assets/icons/heavy-rain.png';
        break;
      case 'snow':
        imagePath = 'assets/icons/snow.png';
        break;
      case 'thunderstorm':
        imagePath = 'assets/icons/storm.png';
        break;
      case 'haze':
        imagePath = 'assets/icons/haze.png';
        break;
      case 'smoke':
        imagePath = 'assets/icons/smoke.png';
        break;
      default:
        imagePath = 'assets/icons/Group.png'; // Default image
    }
    }

    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(imagePath), // ✅ Uses dynamic image path
    );
  }
}
