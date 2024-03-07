import 'dart:io';

import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadCoverImageScreen extends StatefulWidget {
  const UploadCoverImageScreen({super.key});

  @override
  State<UploadCoverImageScreen> createState() => _UploadCoverImageScreenState();
}

class _UploadCoverImageScreenState extends State<UploadCoverImageScreen> {
  late File imageFile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('imageFile')) {
      imageFile = args['imageFile'];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật hình nền"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.done))],
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 160.sp,
                    child: Column(
                      children: [
                        Container(
                            height: 50.sp,
                            padding: EdgeInsets.only(left: 12.sp),
                            alignment: Alignment.centerLeft,
                            child: Text("Ảnh bìa",
                                style: text20.primary.bold)),
                        Container(
                          height: 50.sp,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey
                                          .withOpacity(0.3),
                                      width: 1))),
                          child: Row(
                            children: [
                              SizedBox(width: 12.sp),
                              const Icon(
                                Icons.add_photo_alternate,
                                size: 35,
                              ),
                              SizedBox(
                                width: 16.sp,
                              ),
                              Text("Chọn ảnh từ thư viện", style: text18)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            child: Container(
              height: 185.sp,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(imageFile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                height: 70.sp,
                width: width - 200.sp,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
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
                  padding: EdgeInsets.only(bottom: 8.sp),
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
    );
  }
}
