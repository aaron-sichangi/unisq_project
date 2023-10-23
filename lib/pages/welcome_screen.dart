import 'package:flutter/material.dart';
import 'dart:async';
import 'intro_screen.dart';

class WelcomeScreen extends StatefulWidget
{
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState()=>_WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>
{
  @override
  void initState()
  {
    super.initState();
    Timer(const Duration(seconds:5),
        ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
            (context)=> const IntroPage()
            )
        )
    );
  }
  Widget _container ()=>Container(
    color: Colors.deepOrangeAccent,
    child: Center(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(200),
        ),
        child: Center(
          child: Image.asset('assets/images/bus_booking_image.jpg',
          ),
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: _container(),
    );
  }
}