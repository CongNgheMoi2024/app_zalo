import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputLogin extends StatefulWidget {
  String? title;
  Function? onChanged;
  TextInputLogin({super.key, this.title, this.onChanged});

  @override
  State<TextInputLogin> createState() => _TextInputLoginState();
}

class _TextInputLoginState extends State<TextInputLogin> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.sp,
      margin: EdgeInsets.only(right: 20.sp, left: 20.sp),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          widget.onChanged!(value);
        },
        controller: _controller,
        cursorColor: greyIcBot.withOpacity(0.5),
        decoration: InputDecoration(
          hintText: widget.title ?? "Tiêu đề button",
          hintStyle: text15.regular.copyWith(color: greyIcTop.withOpacity(0.6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
