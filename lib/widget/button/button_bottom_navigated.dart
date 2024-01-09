import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class ButtonBottomNavigated extends StatefulWidget {
  String? title;
  Function? onPressed;
  ButtonBottomNavigated({super.key, this.title, this.onPressed});

  @override
  State<ButtonBottomNavigated> createState() => _ButtonBottomNavigatedState();
}

class _ButtonBottomNavigatedState extends State<ButtonBottomNavigated> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 78.sp,
        width: width,
        child: Center(
          child: GestureDetector(
            onTap: widget.onPressed as void Function()?,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 13.sp),
              width: width - 40.sp,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8.sp)),
              child: Center(
                child: Text(
                  widget.title?.toUpperCase() ?? "Button".toUpperCase(),
                  style: text15.medium.white,
                ),
              ),
            ),
          ),
        ));
  }
}
