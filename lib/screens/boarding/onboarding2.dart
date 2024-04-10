import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class Onboarding2 extends StatefulWidget {
  final VoidCallback onNextPage;
  const Onboarding2({super.key, required this.onNextPage});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
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
              Png.onboarding2,
              width: 300.sp,
              height: 300.sp,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Text(
            "Kết Nối Mọi Người - Sợi Dây Liên Lạc Vô Tận",
            textAlign: TextAlign.center,
            style: text18.regular.bgColor,
          ),
        )
      ]),
    );
  }
}
