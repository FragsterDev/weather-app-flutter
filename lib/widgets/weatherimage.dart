import 'package:flutter/material.dart';

class Weatherimage extends StatelessWidget {
  const Weatherimage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 100,
              height: 100,
              // color: Colors.grey,
              child: Image.asset("assets/icons/Group.png"),
          );
  }
}