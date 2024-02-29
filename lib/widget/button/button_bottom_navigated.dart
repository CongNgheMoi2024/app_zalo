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
        height: 63.sp,
        width: width,
        child: Center(
          child: GestureDetector(
            onTap: widget.onPressed as void Function()?,
            child: Container(
              margin: EdgeInsets.only(
                  left: 55.sp, right: 55.sp, bottom: 5.sp, top: 8.sp),
              width: width - 40.sp,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(28.sp)),
              child: Center(
                child: Text(
                  widget.title ?? "Button",
                  style: text15.medium.white,
                ),
              ),
            ),
          ),
        ));
  }
}
