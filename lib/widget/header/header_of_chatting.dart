import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class HeaderOfChatting extends StatefulWidget {
  const HeaderOfChatting({super.key});

  @override
  State<HeaderOfChatting> createState() => _HeaderOfChattingState();
}

class _HeaderOfChattingState extends State<HeaderOfChatting> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 66.sp,
      width: width,
      padding: EdgeInsets.only(top: 3.sp),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.1,
          0.6,
          0.9,
        ],
        colors: [
          primaryColor.withOpacity(0.7),
          primaryColor.withOpacity(0.5),
          primaryColor.withOpacity(0.4)
        ],
      )),
      child: Row(children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 10.sp,
            ),
            child: Icon(
              Icons.arrow_back,
              size: 35.sp,
              color: whiteColor.withOpacity(0.9),
            ),
          ),
        ),
        Expanded(
          child: Text(
            "Đỗ Quốc Tuấn",
            style: text18.medium.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
            vertical: 10.sp,
          ),
          child: Icon(
            Icons.menu,
            size: 35.sp,
            color: whiteColor.withOpacity(0.9),
          ),
        )
      ]),
    );
  }
}
