import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class ReciverMessItem extends StatefulWidget {
  String? avatarReceiver;
  String? message;
  String? time;
  bool? sex;
  bool? showAvatar;

  ReciverMessItem(
      {super.key,
      this.avatarReceiver,
      this.message,
      this.time,
      this.sex,
      this.showAvatar});

  @override
  State<ReciverMessItem> createState() => _ReciverMessItemState();
}

class _ReciverMessItemState extends State<ReciverMessItem> {
  bool visibleDetail = false;
  void _showMessageDetailsModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      constraints: BoxConstraints(
        maxHeight: height * 0.8,
        maxWidth: width - 20.sp,
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: width,
                child: Center(
                  child: Text(
                    widget.time!,
                    style: text14.regular
                        .copyWith(color: greyIcBot, fontSize: 14.sp),
                  ),
                )),
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
                            width: 45.sp,
                            height: 45.sp,
                            fit: BoxFit.cover,
                          )
                        : widget.sex!
                            ? ImageAssets.pngAsset(Png.imgUserBoy,
                                width: 45.sp, height: 45.sp, fit: BoxFit.cover)
                            : ImageAssets.pngAsset(Png.imgUserGirl,
                                width: 45.sp, height: 45.sp, fit: BoxFit.cover),
                  ),
                ),
                Container(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: width * 0.65,
                    ),
                    margin: EdgeInsets.only(left: 10.sp),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 17.sp),
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: Text(
                      widget.message!,
                      style: text18.primary.regular,
                    )),
              ],
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 55.sp,
                  top: 5.sp,
                ),
                child: Text(
                  "Đã xem",
                  style: text14.medium.copyWith(
                      color: primaryColor.withOpacity(0.8), fontSize: 13.sp),
                )),
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(
                      color: boxMessShareColor.withOpacity(0.4), width: 1.sp)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    ImageAssets.pngAsset(
                      Png.icForward,
                      width: 30.sp,
                      height: 30.sp,
                    ),
                    SizedBox(height: 5.sp),
                    Text(
                      "Chuyển tiếp",
                      style: text14.medium.copyWith(
                          color: lightBlue.withOpacity(0.8), fontSize: 13.sp),
                    )
                  ],
                )
              ]),
            )
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(top: !widget.showAvatar! ? 5.sp : 0, bottom: 2.sp),
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
              !widget.showAvatar!
                  ? Padding(
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
                                    width: 35.sp,
                                    height: 35.sp,
                                    fit: BoxFit.cover)
                                : ImageAssets.pngAsset(Png.imgUserGirl,
                                    width: 35.sp,
                                    height: 35.sp,
                                    fit: BoxFit.cover),
                      ),
                    )
                  : SizedBox(
                      width: 45.sp,
                      height: 35.sp,
                    ),
              InkWell(
                onLongPress: () {
                  _showMessageDetailsModal(context);
                },
                onTap: () {
                  setState(() {
                    visibleDetail = !visibleDetail;
                  });
                },
                child: Container(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: width * 0.6,
                    ),
                    margin: EdgeInsets.only(left: 10.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              !widget.showAvatar! ? 20.sp : 5.sp),
                          topRight: Radius.circular(
                              !widget.showAvatar! ? 20.sp : 5.sp),
                          bottomLeft: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
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
