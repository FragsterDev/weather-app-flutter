// import 'package:flutter/material.dart';

// class City extends StatelessWidget {
//   const City({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 25,),
//                 Text('Pune',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
//                 SizedBox(width: 10,),
//                 Image.asset('assets/icons/Vector.png')
//               ],
//             );
//   }
// }

import 'package:flutter/material.dart';

class City extends StatelessWidget {
  final String cityName; // ✅ Accepts cityName parameter

  const City({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 25),
        Text(
          cityName, // ✅ Now dynamically displays cityName
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Image.asset('assets/icons/Vector.png'),
      ],
    );
  }
}
