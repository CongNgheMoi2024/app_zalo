import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  String? title;
  String? value;
  Function(String)? onTextChanged;
  TextInputWidget({super.key, this.title, this.onTextChanged, this.value});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value ?? "";
    _controller.addListener(() {
      widget.onTextChanged!(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.sp,
      margin: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 0.sp),
      child: TextField(
        controller: _controller,
        cursorColor: greyIcTop,
        decoration: InputDecoration(
          label: Text(
            widget.title ?? "Tiêu đề",
            style: text15.regular.copyWith(color: greyIcTop.withOpacity(0.6)),
          ),
          hintText: widget.title ?? "Tiêu đề",
          hintStyle: text16.regular.copyWith(color: greyIcTop.withOpacity(0.6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: greyIcTop.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: greyIcTop.withOpacity(0.3),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
