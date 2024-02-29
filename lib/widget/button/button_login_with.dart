import 'package:app_zalo/constants/assets.dart';
import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/icons.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class ButtonLoginWith extends StatefulWidget {
  String? title;
  Function? onPressed;
  ButtonLoginWith({super.key, this.title, this.onPressed});

  @override
  State<ButtonLoginWith> createState() => _ButtonLoginWithState();
}

class _ButtonLoginWithState extends State<ButtonLoginWith> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 54.sp,
        width: width,
        child: Center(
          child: GestureDetector(
            onTap: widget.onPressed as void Function()?,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              width: width - 40.sp,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8.sp),
                border:
                    Border.all(color: greyIcBot.withOpacity(0.2), width: 1.sp),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.sp,
                    ),
                    Text(
                      widget.title ?? "Button".toUpperCase(),
                      style: text15.semiBold.textColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
