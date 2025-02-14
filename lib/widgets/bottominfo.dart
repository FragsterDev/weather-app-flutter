import 'package:flutter/material.dart';

class BottomInfo extends StatelessWidget {
  final String sunriseTime;
  final String sunsetTime;
  final double windSpeed;
  final String windDirection;
  final double pressure;

  const BottomInfo({
    Key? key,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 253, 252, 252),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const SizedBox(height: 5),
              Column(
                children: [
                  const Text('Sunrise', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 196, 196, 196))),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset('assets/icons/sunrise.png'),
                  ),
                  Text(sunriseTime, style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 154, 154, 154))),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  const Text('Wind', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 196, 196, 196))),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/icons/wind.png'),
                  ),
                  Text('${windSpeed.toStringAsFixed(1)} km/h $windDirection', 
                      style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 154, 154, 154))),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 5),
              Column(
                children: [
                  const Text('Sunset', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 196, 196, 196))),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset('assets/icons/sunset.png'),
                  ),
                  Text(sunsetTime, style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 154, 154, 154))),
                ],
              ),
              const SizedBox(height: 11),
              Column(
                children: [
                  const Text('Pressure', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 196, 196, 196))),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/icons/pressure.png'),
                  ),
                  Text('${pressure.toStringAsFixed(0)} hPa', style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 154, 154, 154))),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
