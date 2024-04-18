import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String userName;
  const NotificationItem(
      {super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.sp)),
              color: primaryColor.withOpacity(0.1.sp)),
          padding: EdgeInsets.only(top: 5.sp,bottom: 5.sp,left: 10.sp,right: 10.sp),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: userName,
                  style: text12.black.medium
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
