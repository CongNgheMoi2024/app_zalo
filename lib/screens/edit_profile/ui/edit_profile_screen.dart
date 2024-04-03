import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  String? name;
  String? dateOfBirth;
  int? sex;
  String? phone;
  String? avatar;
  EditProfileScreen(
      {super.key,
      this.name,
      this.dateOfBirth,
      this.sex,
      this.phone,
      this.avatar});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return DismissKeyboard(
      child: SafeArea(
          child: Scaffold(
        body: Column(children: [
          HeaderBack(
            notCheck: true,
            title: "Chỉnh sửa thông tin cá nhân",
          ),
          Row(children: [
            Container(
              width: width * 0.25,
              height: height * 0.25,
              color: Colors.red,
              child: widget.avatar != ""
                  ? ImageAssets.networkImage(
                      url: widget.avatar,
                      width: 35.sp,
                      height: 35.sp,
                      fit: BoxFit.cover,
                    )
                  : ImageAssets.pngAsset(
                      Png.imageAvatarChien,
                      width: 35.sp,
                      height: 35.sp,
                      fit: BoxFit.cover,
                    ),
            )
          ])
        ]),
      )),
    );
  }
}
