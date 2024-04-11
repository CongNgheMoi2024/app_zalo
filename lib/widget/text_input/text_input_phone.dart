import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputPhone extends StatefulWidget {
  String? title;
  Function? onChanged;
  Function? onSend;
  TextInputPhone({super.key, this.title, this.onChanged, this.onSend});

  @override
  State<TextInputPhone> createState() => _TextInputPhoneState();
}

class _TextInputPhoneState extends State<TextInputPhone> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(right: 16.sp, left: 16.sp),
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
            width: width - 79.sp,
            child: TextField(
              onChanged: (value) {
                widget.onChanged!(value);
              },
              controller: _controller,
              cursorColor: greyIcBot.withOpacity(0.5),
              decoration: InputDecoration(
                hintText: widget.title ?? "Tiêu đề",
                hintStyle: text16.copyWith(color: greyIcBot.withOpacity(0.7)),
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
              widget.onSend!();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 5.0, left: 8.0),
              child: Text(
                "Gửi",
                style: text14.semiBold.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
