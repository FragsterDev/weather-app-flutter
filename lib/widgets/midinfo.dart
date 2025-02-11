import 'package:flutter/material.dart';

class MidInfo extends StatelessWidget {
  final String time;
  final double rainChance;
  final double low;
  final double high;

  const MidInfo({
    Key? key,
    required this.time,
    required this.high,
    required this.rainChance,
    required this.low,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 248, 248, 248),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('TIME', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                    Text(
                      time,
                      style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('HIGH', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                    Text(
                      "${high.toStringAsFixed(1)}",
                      style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('LOW', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                    Text(
                      "${low.toStringAsFixed(1)}",
                      style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('HUMIDITY', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                    Text(
                      '${rainChance.toStringAsFixed(1)}%',
                      style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
              ),

                  ],
                ),
              ],
            ),
          ),  
        ],
      ),
    );
  }
}
