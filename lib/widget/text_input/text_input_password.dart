import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputPassword extends StatefulWidget {
  String? title;
  Function? onChanged;
  TextInputPassword({super.key, this.title, this.onChanged});

  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  final TextEditingController _controller = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(right: 20.sp, left: 20.sp, top: 0.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 56.sp,
            width: width - 92.sp,
            child: TextField(
              obscureText: _obscureText,
              onChanged: (value) {
                widget.onChanged!(value);
              },
              controller: _controller,
              cursorColor: greyIcBot.withOpacity(0.5),
              decoration: InputDecoration(
                hintText: widget.title ?? "Tiêu đề",
                hintStyle: text15.copyWith(color: greyIcTop.withOpacity(0.6)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 16.0, left: 3.0),
              child: ImageAssets.pngAsset(
                  _obscureText == false ? Png.icView : Png.icHide,
                  width: 24.sp,
                  fit: BoxFit.cover,
                  color: greyIcTop.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
