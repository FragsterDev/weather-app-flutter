// import 'package:flutter/material.dart';
// import '../providers/temperature_unit_provider.dart';
// import 'package:provider/provider.dart';

// class TemperatureDisplay extends StatelessWidget {
//   final double temp;
//   final double feels; // ✅ Accepts temperature as a parameter

//   const TemperatureDisplay({Key? key, required this.temp, required this.feels}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(width: 35),
//             Text(
//               temp.round().toString(), // ✅ Convert temp to a string
//               style: const TextStyle(fontSize: 75, fontWeight: FontWeight.w500),
//             ),
//             const Text(
//               '\u00B0', // ✅ Degree symbol
//               style: TextStyle(fontSize: 75, fontWeight: FontWeight.w500),
//             ),
//             const Text(
//               'C', // ✅ Celsius indicator
//               style: TextStyle(fontSize: 75, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Feels Like ', style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 142, 142, 142)),),
//             Text("${feels.toStringAsFixed(0)}\u00B0C", style: TextStyle(fontSize: 18,
//             color: Color.fromARGB(255, 142, 142, 142),
//             ),),
//           ],
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/temperature_unit_provider.dart';

class TemperatureDisplay extends StatelessWidget {
  final double temp;
  final double feels;

  const TemperatureDisplay({
    Key? key, 
    required this.temp, 
    required this.feels
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TemperatureUnitProvider>(
      builder: (context, tempUnitProvider, child) {
        final convertedTemp = tempUnitProvider.convertTemperature(temp);
        final convertedFeels = tempUnitProvider.convertTemperature(feels);
        
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 35),
                Text(
                  convertedTemp.round().toString(),
                  style: const TextStyle(
                    fontSize: 75, 
                    fontWeight: FontWeight.w500
                  ),
                ),
                // const Text(
                //   '\u00B0',
                //   style: TextStyle(
                //     fontSize: 75, 
                //     fontWeight: FontWeight.w500
                //   ),
                // ),
                Text(
                  tempUnitProvider.unitSymbol,
                  style: const TextStyle(
                    fontSize: 75, 
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Feels Like ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 142, 142, 142)
                  ),
                ),
                Text(
                  "${convertedFeels.toStringAsFixed(0)}\u00B0${tempUnitProvider.unitSymbol}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 142, 142, 142),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}