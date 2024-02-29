import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/button/button_bottom_next.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatarScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;
  const UploadAvatarScreen({super.key, this.profileData = const {}});

  @override
  State<UploadAvatarScreen> createState() => _UploadAvatarScreenState();
}

class _UploadAvatarScreenState extends State<UploadAvatarScreen> {
  int? selectedRadio;

  int sizeImage = 0;
  File? pathImage1;
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final XFile? pickedFile1 = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      if (pickedFile1 != null) {
        setState(() {
          pathImage1 = File(pickedFile1.path);
          sizeImage = pathImage1!.lengthSync();
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: height * 0.13,
                  width: width,
                ),
                Text("Cập nhật ảnh đại diện",
                    style: text28.black.medium, textAlign: TextAlign.center),
                SizedBox(height: 13.sp),
                Text(
                    "Giúp bạn bè dễ dàng nhận ra bạn hơn.\nThông tin này sẽ được công khai.",
                    style: text17.black.regular,
                    textAlign: TextAlign.center),
                Container(
                  height: 314.sp,
                  width: width,
                  margin: EdgeInsets.only(
                    top: 35.sp,
                    left: 16.sp,
                    right: 16.sp,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Center(
                            child: pathImage1 != null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200.sp),
                                        border: Border.all(
                                            color: whiteColor.withOpacity(0.9),
                                            width: 7),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 9,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(200.sp),
                                      child: Image.file(
                                        pathImage1 ?? File(""),
                                        height: 240.sp,
                                        width: 240.sp,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 240.sp,
                                    width: 240.sp,
                                    decoration: BoxDecoration(
                                        color: grey03,
                                        borderRadius:
                                            BorderRadius.circular(200.sp),
                                        border: Border.all(
                                            color: whiteColor.withOpacity(0.9),
                                            width: 7),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 9,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]),
                                    child: Center(
                                        child: ImageAssets.pngAsset(
                                            Png.icAddImageAvatar,
                                            width: 60.sp,
                                            height: 60.sp,
                                            color: whiteColor.withOpacity(0.9),
                                            fit: BoxFit.cover)),
                                  ),
                          )),
                      sizeImage > 300000
                          ? Text(
                              "Ảnh phải kích thước nhỏ hơn 300KB",
                              style: text15.error.regular,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ]),
            ))
          ],
        )),
        bottomNavigationBar: Container(
          height: 165.sp,
          padding: EdgeInsets.only(bottom: 27.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonBottomNavigated(
                title: "Lưu",
                onPressed: () {
                  // Navigator.pushNamed(context, RouterName.verifyRegisterScreen);
                },
              ),
              ButtonBottomNext(
                title: "Lúc khác",
                onPressed: () {
                  Navigator.pushNamed(context, RouterName.dashboardScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
