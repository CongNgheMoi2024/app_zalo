import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class Onboarding1 extends StatefulWidget {
  final VoidCallback onNextPage;
  const Onboarding1({super.key, required this.onNextPage});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
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
              Png.onboarding1,
              width: 300.sp,
              height: 300.sp,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Text(
            "Nói chuyện là rẻ tiền, vì vậy hãy trò chuyện bằng trái tim của bạn.",
            textAlign: TextAlign.center,
            style: text18.regular.bgColor,
          ),
        )
      ]),
    );
  }
}
