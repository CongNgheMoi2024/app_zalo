import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderOfChatting extends StatefulWidget {
  String? nameReceiver;
  String? timeActive;
  String? urlAvatar;
  bool? sex;
  Function? actionMenuMore;
  bool? isGroup;
  HeaderOfChatting(
      {super.key,
      this.nameReceiver,
      this.timeActive,
      this.urlAvatar,
      this.sex,
      this.actionMenuMore,
      this.isGroup = false});

  @override
  State<HeaderOfChatting> createState() => _HeaderOfChattingState();
}

class _HeaderOfChattingState extends State<HeaderOfChatting> {
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
          primaryColor.withOpacity(0.7),
          primaryColor.withOpacity(0.5),
          primaryColor.withOpacity(0.4)
        ],
      )),
      child: Row(children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, RouterName.dashboardScreen);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 11.sp,
            ),
            child: Icon(
              Icons.arrow_back,
              size: 31.sp,
              color: whiteColor.withOpacity(0.9),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 10.sp,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.sp),
            child: widget.urlAvatar != ""
                ? ImageAssets.networkImage(
                    url: widget.urlAvatar!,
                    width: 45.sp,
                    height: 45.sp,
                    fit: BoxFit.cover)
                : widget.isGroup == true
                    ? ImageAssets.pngAsset(Png.icAvatarGroup,
                        width: 45.sp, height: 45.sp, fit: BoxFit.cover)
                    : widget.sex == true
                        ? ImageAssets.pngAsset(Png.imgUserBoy,
                            width: 45.sp, height: 45.sp, fit: BoxFit.cover)
                        : ImageAssets.pngAsset(Png.imgUserGirl,
                            width: 45.sp, height: 45.sp, fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.nameReceiver ?? "Người dùng Zola",
                style: text18.medium.white,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.sp,
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 10.sp,
                      color: greenColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    "Hoạt động ${widget.timeActive}",
                    style: text14.medium.copyWith(
                      color: whiteColor.withOpacity(0.8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        InkWell(
          onTap: widget.actionMenuMore == null
              ? () {}
              : () {
                  widget.actionMenuMore!();
                },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 12.sp,
            ),
            child: Icon(
              Icons.menu,
              size: 31.sp,
              color: whiteColor.withOpacity(0.9),
            ),
          ),
        )
      ]),
    );
  }
}
