import 'package:flutter/material.dart';

class MidInfo extends StatelessWidget {
  const MidInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: 360,
              height: 100,
              // color: const Color.fromARGB(255, 248, 248, 248),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 248, 248, 248),
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20,20,20,8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('TIME',style: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),),
                        Text('UV', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                        Text('%RAIN', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                        Text('AQ', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182))),
                        ],
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width:20,),
                      Text('11:25 AM',style: TextStyle(color: Color.fromARGB(255, 10, 8, 8), fontSize: 20),),
                      SizedBox(width:25,),
                      Text('4', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
                      SizedBox(width:65,),
                      Text('58%', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
                      SizedBox(width:46,),
                      Text('22', style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
                      ],
                  )
                ],
              ),
            );
  }
}