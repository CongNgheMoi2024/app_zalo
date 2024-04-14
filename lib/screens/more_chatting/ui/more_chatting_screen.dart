import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/header/header_back.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:flutter/material.dart';

class MoreChattingScreen extends StatefulWidget {
  const MoreChattingScreen({super.key});

  @override
  State<MoreChattingScreen> createState() => _MoreChattingScreenState();
}

class _MoreChattingScreenState extends State<MoreChattingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTrans(
              title: "Tùy chọn",
            ),
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              width: width,
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: ImageAssets.pngAsset(
                        Png.imgAnhBia,
                        width: 100.sp,
                        height: 100.sp,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 3.sp,
                      bottom: 3.sp,
                      child: Container(
                          height: 25.sp,
                          width: 25.sp,
                          decoration: BoxDecoration(
                              color: greyIcTop.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(80.sp)),
                          child: Icon(
                            Icons.camera_enhance_outlined,
                            size: 17.sp,
                            color: whiteColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.065,
                  child: Center(
                    child: Text(
                      "Báo cáo Công nghê",
                      style: text18.primary.medium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Icon(Icons.edit_outlined, size: 20.sp, color: primaryColor)
              ],
            ),
            Container(
              height: 55.sp,
              width: width,
              color: Colors.red,
              child: Text("More chatting"),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.sp,
                  horizontal: 10.sp,
                ),
                decoration: BoxDecoration(),
                child: Text("Xóa nhóm", style: text17.primary.regular))
          ],
        ),
      ),
    );
  }
}
