import 'dart:async';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String accessToken = HiveStorage().token;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 2500),
      () {
        if (accessToken != "") {
          Navigator.pushReplacementNamed(context, RouterName.dashboardScreen);
        } else {
          Navigator.pushReplacementNamed(context, RouterName.onBoardingScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.sp),
            child: ImageAssets.pngAsset(
              Png.logoZalo,
              width: 100,
              height: 100,
            ),
          ),
        )));
  }
}
