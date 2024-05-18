import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:flutter/material.dart';

class InforChatSimple extends StatefulWidget {
  String? avatar;
  String? name;
  bool? sex;
  InforChatSimple({super.key, this.avatar, this.name, this.sex});

  @override
  State<InforChatSimple> createState() => _InforChatSimpleState();
}

class _InforChatSimpleState extends State<InforChatSimple> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                child: ImageAssets.networkImage(
                  url: widget.avatar ?? "",
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
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.065,
              child: Center(
                child: Text(
                  widget.name ?? "User name",
                  style: text18.primary.medium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Icon(Icons.edit_outlined, size: 20.sp, color: primaryColor),
          ],
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.sp),
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            child: Icon(
              Icons.cancel_schedule_send_outlined,
              size: 30.sp,
              color: errorColor,
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 10.sp),
                padding: EdgeInsets.symmetric(
                  vertical: 15.sp,
                  horizontal: 10.sp,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: primaryColor.withOpacity(0.2), width: 1.sp),
                    bottom: BorderSide(
                        color: primaryColor.withOpacity(0.2), width: 1.sp),
                  ),
                ),
                child: Text("Hủy kết bạn", style: text17.error.regular)),
          ),
        ],
      ),
    ])));
  }
}
