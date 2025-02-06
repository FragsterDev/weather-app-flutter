// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 249, 249, 249)
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(8,8,16,8),
                      child: InkWell(
                        onTap: () => {},
                        child: Icon(Icons.search, size: 35,),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(15),
                    label: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
                      child: Text('Search Location', style: TextStyle(fontSize: 20),),
                    ),
                    border: InputBorder.none,
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(20)
                    // )
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              // color: Colors.grey,
              child: Image.asset("assets/icons/Group.png"),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 25,),
                  Text('Pune',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(width: 10,),
                  Image.asset('assets/icons/Vector.png')
                ],
              ),
            ),
            Text('25',style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),),
            Container(
              width: 360,
              height: 100,
              // color: const Color.fromARGB(255, 248, 248, 248),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 248, 248, 248),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,20,8),
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
                      Text('11:25 AM',style: TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontSize: 20),),
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
            )
          ],
                ),
        ),),
    );
  }
}