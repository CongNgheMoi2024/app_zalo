import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String userName;
  final String type;
  const NotificationItem(
      {super.key, required this.userName, required this.type});

  @override
  Widget build(BuildContext context) {
    String notification = "";

    switch (type) {
      case "REMOVE_MEMBER":
        notification = " bị xoá khỏi nhóm";
        break;
      case "ADD_MEMBER":
        notification = " được thêm vào nhóm";
        break;
      case "LEAVE_GROUP":
        notification = " đã rời nhóm";
        break;
      case "ADD_SUB_ADMIN":
        notification = " được làm phó nhóm";
        break;
      case "REMOVE_SUB_ADMIN":
        notification = " bị thu hồi phó nhóm";
        break;
      case "CHANGE_ADMIN":
        notification = " lên làm trưởng nhóm ";
        break;
    }
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
                TextSpan(
                    text: notification,
                    style: text12.black
                )
              ]
            ),
          ),
        )
      ),
    );
  }
}
