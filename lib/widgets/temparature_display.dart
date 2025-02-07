import 'package:flutter/material.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 35,),
                Text('25',style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),),
                Text('\u00B0',style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),),
                Text('C',style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),),
              ],
            );
  }
}