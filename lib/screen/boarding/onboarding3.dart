import 'package:app_zalo/constants/icons.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20.sp),
          height: height * 0.6,
          width: width,
          child: Center(
            child: Image.asset(
              Png.onboarding3,
              width: 300.sp,
              height: 300.sp,
            ),
          ),
        ),
        Expanded(
            child: Text(
          "Go on holiday with a smile",
        ))
      ]),
    );
  }
}
