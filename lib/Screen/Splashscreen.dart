import 'dart:async';


import 'package:flutter/material.dart';
import 'package:internshiptask/Screen/LoginChoiceScreen.dart';
import 'package:internshiptask/Screen/StudentLoginScreen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 5), () {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const Color mateBlack = Color(0xFF242424);
    return Scaffold(
      //backgroundColor: Color(0xFF242424),
      backgroundColor: Colors.blueAccent,
      body: SafeArea(child: Center(child: Image.asset('Image/ezi2.png',height: 550,width: 1000,))),
    );
  }
}
