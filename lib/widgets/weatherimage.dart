// import 'package:flutter/material.dart';

// class Weatherimage extends StatelessWidget {
//   const Weatherimage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//               width: 100,
//               height: 100,
//               // color: Colors.grey,
//               child: Image.asset("assets/icons/Group.png"),
//           );
//   }
// }

import 'package:flutter/material.dart';

class Weatherimage extends StatelessWidget {
  final String condition; // ✅ Accepts the weather condition as a parameter

  const Weatherimage({Key? key, required this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath;

    // ✅ Match weather conditions to images
    switch (condition.toLowerCase()) {
      case 'clear':
        imagePath = 'assets/icons/Group.png';
        break;
      case 'clouds':
        imagePath = 'assets/icons/Group.png';
        break;
      case 'rain':
        imagePath = 'assets/icons/Group.png';
        break;
      case 'snow':
        imagePath = 'assets/icons/Group.png';
        break;
      case 'thunderstorm':
        imagePath = 'assets/icons/Group.png';
        break;
      default:
        imagePath = 'assets/icons/Group.png'; // Default image
    }

    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(imagePath), // ✅ Uses dynamic image path
    );
  }
}
