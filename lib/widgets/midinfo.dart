// import 'package:flutter/material.dart';

// class MidInfo extends StatelessWidget {
//   const MidInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               width: 360,
//               height: 100,
//               // color: const Color.fromARGB(255, 248, 248, 248),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: const Color.fromARGB(255, 248, 248, 248),
//               ),
//               child: Column(
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20,20,20,8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text('TIME',style: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),),
//                         Text('UV', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
//                         Text('%RAIN', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
//                         Text('AQ', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
//                         ],
//                     ),
//                   ),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(width:20,),
//                       Text('11:25 AM',style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
//                       SizedBox(width:25,),
//                       Text('4', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
//                       SizedBox(width:65,),
//                       Text('58%', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
//                       SizedBox(width:46,),
//                       Text('22', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
//                       ],
//                   )
//                 ],
//               ),
//             );
//   }
// }

import 'package:flutter/material.dart';

class MidInfo extends StatelessWidget {
  final String time;
  final double uvIndex;
  final double rainChance;
  final int aqi;

  const MidInfo({
    Key? key,
    required this.time,
    required this.uvIndex,
    required this.rainChance,
    required this.aqi,
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('TIME', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                Text('UV', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                Text('%RAIN', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                Text('AQ', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                time,
                style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
              ),
              Text(
                uvIndex.toStringAsFixed(1),
                style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
              ),
              Text(
                '${rainChance.toStringAsFixed(1)}%',
                style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
              ),
              Text(
                aqi.toString(),
                style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
