import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderTrans extends StatefulWidget {
  bool? notCheck;
  String? title;
  final Function? actionCheck;
  HeaderTrans({super.key, this.notCheck = false, this.title, this.actionCheck});

  @override
  State<HeaderTrans> createState() => _HeaderTransState();
}

class _HeaderTransState extends State<HeaderTrans> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 66.sp,
      width: width,
      padding: EdgeInsets.only(top: 3.sp),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
                child: Icon(
                  Icons.arrow_back,
                  size: 35.sp,
                  color: primaryColor.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.title ?? '', style: text18.primary.regular)],
          ),
        ),
        SizedBox(width: 55.sp, height: 30.sp),
      ]),
    );
  }
}
