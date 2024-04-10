import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class SenderMessItem extends StatefulWidget {
  String? content;
  String? time;
  SenderMessItem({super.key, this.content, this.time});

  @override
  State<SenderMessItem> createState() => _SenderMessItemState();
}

class _SenderMessItemState extends State<SenderMessItem> {
  bool visibleDetail = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          visibleDetail
              ? SizedBox(
                  width: width,
                  child: Center(
                    child: Text(
                      widget.time!,
                      style: text14.regular
                          .copyWith(color: greyIcBot, fontSize: 14.sp),
                    ),
                  ))
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    visibleDetail = !visibleDetail;
                  });
                },
                child: Container(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: width * 0.65,
                    ),
                    margin: EdgeInsets.only(right: 15.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                        bottomLeft: Radius.circular(20.sp),
                      ),
                    ),
                    child: Text(
                      widget.content!,
                      style: text16.primary.regular,
                    )),
              ),
            ],
          ),
          visibleDetail
              ? Container(
                  margin: EdgeInsets.only(
                    right: 20.sp,
                    top: 5.sp,
                  ),
                  child: Text(
                    "Đã xem",
                    style: text14.medium.copyWith(
                        color: primaryColor.withOpacity(0.8), fontSize: 13.sp),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
