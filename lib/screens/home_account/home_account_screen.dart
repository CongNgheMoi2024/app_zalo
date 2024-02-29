import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_actions_bar.dart';
import 'package:flutter/material.dart';

class HomeAccountScreen extends StatefulWidget {
  const HomeAccountScreen({super.key});

  @override
  State<HomeAccountScreen> createState() => _HomeAccountScreenState();
}

class _HomeAccountScreenState extends State<HomeAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DismissKeyboard(
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Stack(
              children: [
                Container(
                  height: 185.sp,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Png.imgAnhBia),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                      height: 185.sp,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.4,
                            0.5,
                            0.6,
                            0.7,
                          ],
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.17),
                            Colors.black.withOpacity(0.21),
                            Colors.black.withOpacity(0.27),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.sp),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.sp, right: 15.sp),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80.sp),
                                  child: ImageAssets.pngAsset(
                                    Png.imageAvatarChien,
                                    width: 55.sp,
                                    height: 55.sp,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ChiếnyeuThu",
                                    style: text18.white.medium,
                                  ),
                                  SizedBox(
                                    height: 3.sp,
                                  ),
                                  Text(
                                    "Xem trang cá nhân",
                                    style: text15.regular.copyWith(
                                        color: Colors.white.withOpacity(0.8)),
                                  )
                                ],
                              )
                            ]),
                      )),
                ),
              ],
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.sp,
                        bottom: 10.sp,
                      ),
                      child:
                          Text("Thông tin cá nhân", style: text16.medium.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: width * 0.25,
                              child: Text(
                                "Giới tính",
                                style: text16.black.regular,
                              )),
                          Text("Nam", style: text16.black.regular),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5.sp,
                      width: width,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: width * 0.25,
                              child: Text(
                                "Ngày sinh",
                                style: text16.black.regular,
                              )),
                          Text(
                            "30/11/2002",
                            style: text16.black.regular,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5.sp,
                      width: width,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.25,
                              child: Text(
                                "Điện thoại",
                                style: text16.black.regular,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "0395309735",
                                style: text16.black.regular,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.sp),
                                width: width * 0.66,
                                child: Text(
                                  "Số điện thoại chỉ hiển thị với người có lưu số bạn trong danh bạ máy",
                                  style: text15.textColor.regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 42.sp,
                        margin: EdgeInsets.only(bottom: 5.sp, top: 18.sp),
                        width: width - 30.sp,
                        decoration: BoxDecoration(
                            color: grey03,
                            borderRadius: BorderRadius.circular(28.sp)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: blackColor.withOpacity(0.8),
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            Text(
                              "Chỉnh sửa",
                              style: text15.medium.copyWith(
                                color: blackColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
                margin: EdgeInsets.only(top: 15.sp),
                height: 10.sp,
                width: width,
                color: grey03.withOpacity(0.5)),
            Container(
              padding: EdgeInsets.only(
                left: 15.sp,
                right: 15.sp,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 18.sp, bottom: 18.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: width * 0.15,
                            child: Icon(
                              Icons.published_with_changes,
                              size: 25.sp,
                              color: blackColor.withOpacity(0.8),
                            )),
                        Text("Đổi mật khẩu", style: text16.black.regular),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5.sp,
                    width: width,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18.sp, bottom: 18.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: width * 0.15,
                            child: Icon(
                              Icons.live_help_outlined,
                              size: 25.sp,
                              color: blackColor.withOpacity(0.8),
                            )),
                        Text("Liên hệ hỗ trợ", style: text16.black.regular),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5.sp,
                    width: width,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 45.sp,
                      margin: EdgeInsets.only(bottom: 15.sp, top: 15.sp),
                      width: width - 40.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.sp),
                        border: Border.all(color: errorColor, width: 1.sp),
                      ),
                      child: Center(
                        child: Text(
                          "Đăng xuất",
                          style: text15.medium.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])))
    ]))));
  }
}
