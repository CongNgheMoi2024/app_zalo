import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonBottomNext extends StatefulWidget {
  String? title;
  Function? onPressed;
  ButtonBottomNext({super.key, this.title, this.onPressed});

  @override
  State<ButtonBottomNext> createState() => _ButtonBottomNextState();
}

class _ButtonBottomNextState extends State<ButtonBottomNext> {
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
                  borderRadius: BorderRadius.circular(28.sp),
                  border:
                      Border.all(color: greyIcBot.withOpacity(0.4), width: 1)),
              child: Center(
                child: Text(
                  widget.title ?? "Button",
                  style: text15.medium.bgColor,
                ),
              ),
            ),
          ),
        ));
  }
}
