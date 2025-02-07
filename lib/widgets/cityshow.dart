import 'package:flutter/material.dart';

class City extends StatelessWidget {
  const City({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 25,),
                Text('Pune',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Image.asset('assets/icons/Vector.png')
              ],
            );
  }
}