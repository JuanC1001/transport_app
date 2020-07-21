import 'dart:async';
import 'package:flutter/material.dart';
import 'Inicio.dart';



class SplashScreen extends StatefulWidget  {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => SplashScreen());
  }
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Inicio())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      body: Center(
        child: Image.asset('images/logo.jpg', width: 200, height: 200),
      ),
    );
  }
}
