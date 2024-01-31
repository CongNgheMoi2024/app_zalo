import 'package:app_zalo/constants/assets.dart';
import 'package:app_zalo/constants/icons.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
        child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
          SizedBox(height: 40.sp),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.sp, right: 20.sp, top: 12.sp, bottom: 12.sp),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: ImageAssets.pngAsset(Png.imgUserGirl,
                      width: 65.sp, height: 65.sp, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thư Dễ Thương",
                      style: text16.black.regular,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    SizedBox(
                      height: 20.sp,
                      width: width * 0.55,
                      child: Text(
                        "Lần theo những dấu vết đánh rơi. Chờ mãi nơi này một cảm giác",
                        overflow: TextOverflow.ellipsis,
                        style: text16.textColor.regular,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.sp),
                child: Text(
                  "3 giờ",
                  style: text15.regular.textColor,
                ),
              ),
            ],
          ),
          Container(
            height: 0.5.sp,
            width: width,
            color: grey03.withOpacity(0.5),
            margin: EdgeInsets.only(left: 105.sp),
          )
        ])))));
  }
}
