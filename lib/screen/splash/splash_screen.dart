import 'dart:async';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 50),
      () {
        Navigator.pushReplacementNamed(context, RouterName.dashboardScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Colors.red,
      height: 500.sp,
      child: Center(
        child: Text('Splash Screen'),
      ),
    )));
  }
}
