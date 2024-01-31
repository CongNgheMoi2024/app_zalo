import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class HeaderActionsBar extends StatefulWidget {
  final IconData? icon1;
  final IconData? icon2;
  final Function? action1;
  final Function? action2;
  const HeaderActionsBar(
      {super.key, this.icon1, this.icon2, this.action1, this.action2});

  @override
  State<HeaderActionsBar> createState() => _HeaderActionsBarState();
}

class _HeaderActionsBarState extends State<HeaderActionsBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 71.sp,
      width: width,
      padding: EdgeInsets.only(top: 3.sp),
      color: primaryColor.withOpacity(0.9),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Icon(
                Icons.search,
                size: 35.sp,
                color: whiteColor.withOpacity(0.9),
              ),
            ),
            Container(
              height: 56.sp,
              width: width * 0.69 - 57.sp,
              padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 6.sp),
              child: TextField(
                cursorColor: grey03,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(
                      color: whiteColor.withOpacity(0.8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.icon1 == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(width: 0.sp),
                    )
                  : GestureDetector(
                      onTap: widget.action1 == null
                          ? () {}
                          : () {
                              widget.action1!();
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          widget.icon1,
                          size: 30.sp,
                          color: whiteColor,
                        ),
                      ),
                    ),
              widget.icon2 == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(width: 0.sp),
                    )
                  : GestureDetector(
                      onTap: widget.action2 == null
                          ? () {}
                          : () {
                              widget.action2!();
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          widget.icon2,
                          size: 35.sp,
                          color: whiteColor,
                        ),
                      ),
                    ),
            ],
          ),
        )
      ]),
    );
  }
}
