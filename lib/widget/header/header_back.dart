import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderBack extends StatefulWidget {
  bool? notCheck;
  String? title;
  final Function? actionCheck;
  HeaderBack({super.key, this.notCheck = false, this.title, this.actionCheck});

  @override
  State<HeaderBack> createState() => _HeaderBackState();
}

class _HeaderBackState extends State<HeaderBack> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 66.sp,
      width: width,
      padding: EdgeInsets.only(top: 3.sp),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [
          0.1,
          0.6,
          0.9,
        ],
        colors: [
          primaryColor.withOpacity(0.9),
          primaryColor.withOpacity(0.7),
          primaryColor.withOpacity(0.6)
        ],
      )),
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
                  color: whiteColor.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.title ?? '', style: text18.white.semiBold)],
          ),
        ),
        widget.notCheck == false
            ? InkWell(
                onTap: widget.actionCheck == null
                    ? () {}
                    : () {
                        widget.actionCheck!();
                      },
                child: SizedBox(
                  width: 65.sp,
                  child: Center(
                      child: Icon(
                    Icons.check,
                    color: whiteColor,
                    size: 35.sp,
                  )),
                ),
              )
            : SizedBox(width: 65.sp, height: 35.sp)
      ]),
    );
  }
}
