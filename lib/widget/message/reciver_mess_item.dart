import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class ReciverMessItem extends StatefulWidget {
  String? avatarReceiver;
  String? message;
  String? time;
  bool? sex;
  ReciverMessItem(
      {super.key, this.avatarReceiver, this.message, this.time, this.sex});

  @override
  State<ReciverMessItem> createState() => _ReciverMessItemState();
}

class _ReciverMessItemState extends State<ReciverMessItem> {
  bool visibleDetail = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10.sp,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.sp),
                  child: widget.avatarReceiver != ""
                      ? Image.network(
                          widget.avatarReceiver!,
                          width: 35.sp,
                          height: 35.sp,
                          fit: BoxFit.cover,
                        )
                      : widget.sex!
                          ? ImageAssets.pngAsset(Png.imgUserBoy,
                              width: 35.sp, height: 35.sp, fit: BoxFit.cover)
                          : ImageAssets.pngAsset(Png.imgUserGirl,
                              width: 35.sp, height: 35.sp, fit: BoxFit.cover),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    visibleDetail = !visibleDetail;
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                        bottomRight: Radius.circular(20.sp),
                      ),
                    ),
                    child: Text(
                      widget.message!,
                      style: text16.primary.regular,
                    )),
              ),
            ],
          ),
          visibleDetail
              ? Container(
                  margin: EdgeInsets.only(
                    left: 55.sp,
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
