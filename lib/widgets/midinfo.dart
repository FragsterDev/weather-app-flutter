import 'package:flutter/material.dart';

class MidInfo extends StatelessWidget {
  final String time;
  final double rainChance;
  // final double low;
  // final double high;
  final String condition;
  final double visibility;

  const MidInfo({
    Key? key,
    required this.time,
    // required this.high,
    required this.rainChance,
    // required this.low,
    required this.condition,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 253, 252, 252),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TIME', style: TextStyle(color: Color.fromARGB(255, 196, 196, 196))),
                    SizedBox(height: 10,),
                    Text(
                      time,
                      style: const TextStyle(color: Color.fromARGB(255, 154, 154, 154), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('COND.', style: TextStyle(color: Color.fromARGB(255, 196, 196, 196))),
                    SizedBox(height: 10,),
                    Text(
                      condition,
                      style: const TextStyle(color: Color.fromARGB(255, 154, 154, 154), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('VISIBILITY', style: TextStyle(color: Color.fromARGB(255, 196, 196, 196))),
                    SizedBox(height: 10,),
                    Text(
                      "${(visibility/1000).toInt()} km",
                      style: const TextStyle(color: Color.fromARGB(255, 154, 154, 154), fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('HUMIDITY', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                    SizedBox(height: 10,),
                    Text(
                      '${(rainChance).toInt()}%',
                      style: const TextStyle(color: Color.fromARGB(255, 154, 154, 154), fontSize: 20),
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
