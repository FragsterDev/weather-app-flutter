import 'package:flutter/material.dart';

class TemperatureDisplay extends StatelessWidget {
  final double temp; // ✅ Accepts temperature as a parameter

  const TemperatureDisplay({Key? key, required this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 35),
        Text(
          temp.toStringAsFixed(1), // ✅ Convert temp to a string with 1 decimal place
          style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w500),
        ),
        const Text(
          '\u00B0', // ✅ Degree symbol
          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),
        ),
        const Text(
          'C', // ✅ Celsius indicator
          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
