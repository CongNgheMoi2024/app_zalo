import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/widget/header/header_back.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final XFile? pickedFile1 = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile1 != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
            context, RouterName.uploadImageCoverScreen,
            arguments: {'imageFile': File(pickedFile1.path)});
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void showCustomModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 160.sp,
        child: Column(
          children: [
            Container(
              height: 50.sp,
              padding: EdgeInsets.only(left: 18.sp),
              alignment: Alignment.centerLeft,
              child: Text(
                "Ảnh bìa",
                style: text18.primary.semiBold,
              ),
            ),
            GestureDetector(
              onTap: () {
                _pickImage();
              },
              child: Container(
                height: 50.sp,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 18.sp),
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 30,
                      color: primaryColor.withOpacity(0.8),
                    ),
                    SizedBox(width: 18.sp),
                    Text(
                      "Chọn ảnh từ thư viện",
                      style: text16.primary.regular,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('imageFile')) {
      imageFile = args['imageFile'];
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderBack(
              title: "Cập nhật ảnh Bìa",
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showCustomModalBottomSheet(context);
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
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.2, 0.3, 0.5, 0.7, 0.8],
                          colors: [
                            Colors.black.withOpacity(0.04),
                            Colors.black.withOpacity(0.10),
                            Colors.black.withOpacity(0.15),
                            Colors.black.withOpacity(0.22),
                            Colors.black.withOpacity(0.29),
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
                                    "User Name",
                                    style: text18.white.medium,
                                  ),
                                  SizedBox(
                                    height: 3.sp,
                                  ),
                                  Text(
                                    "Trang cá nhân",
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
          ],
        ),
      ),
    );
  }
}
