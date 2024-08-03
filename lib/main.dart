import 'package:flutter/material.dart';
import 'package:internshiptask/Screen/FrontPageDesigning.dart';
import 'package:internshiptask/Screen/Splashscreen.dart';
import 'package:internshiptask/Screen/StudentLoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.black,
        primarySwatch:Colors.green,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Splashscreen(),
    );
  }
}