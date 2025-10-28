import "dart:async";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:flutter/material.dart";
import 'nutriMAMAScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const NutriMAMAScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 238, 230),
      body: Center(
        //child: Image.asset("assets/images/nutriMAMA.png")
        child: LoadingAnimationWidget.threeRotatingDots(
          color: const Color.fromARGB(255, 246, 238, 230),
          size: 100
          ),
      ),
    );
  }
}