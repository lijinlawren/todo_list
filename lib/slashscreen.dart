import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/login.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: FlutterSplashScreen.fadeIn(
            backgroundColor: Colors.white,
            childWidget: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/images/todo_logo.png"),
            ),
            defaultNextScreen: const login(),
          ),
        ),
      ],),
    );
  }
}
