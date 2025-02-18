import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child: Icon(Icons.local_activity));
    }
}