import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stroop_test/home.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>homepage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Stroop Test",
              style: TextStyle(
                  fontSize: 55.0,
                  color: Colors.white,
                  fontFamily: "Satisfy"
              ),
            ),
          ],
        )
      ),
    );
  }
}
