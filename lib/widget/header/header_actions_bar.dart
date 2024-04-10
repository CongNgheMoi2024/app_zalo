import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
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
                width: width * 0.69 -
                    57.sp +
                    (widget.icon1 == null ? 48.sp : 0) +
                    (widget.icon2 == null ? 48.sp : 0),
                padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 6.sp),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterName.searchByPhoneScreen);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      child: Text(
                        'Tìm kiếm',
                        style: text18.regular.copyWith(
                          color: whiteColor.withOpacity(0.7),
                        ),
                      ),
                    )))
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
                  ? Container(width: 0.sp)
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
                  ? Container(width: 0.sp)
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
