import 'package:app_zalo/constants/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagePageView extends StatelessWidget {
  final String url;
  const ImagePageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Image Page View"),
          backgroundColor: primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(5.sp),
          child: ExtendedImageGesturePageView(
            // Danh sách các hình ảnh để hiển thị trong page view
            children: [
              ExtendedImage.network(
                url,
                fit: BoxFit.contain,
                cache: true,
                // Thêm các tùy chọn cho ExtendedImageGesturePageView nếu cần
              ),
              // Bạn có thể thêm các hình ảnh khác vào danh sách nếu cần
            ],
          ),
        ),
      ),
    );
  }
}
