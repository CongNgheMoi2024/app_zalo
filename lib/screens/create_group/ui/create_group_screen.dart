import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: SafeArea(
            child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextInputWidget(
                      title: "Nhập tên bạn bè cần chuyển tiếp",
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          print("Refreshed");
                        },
                        child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Container()),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                    height: 100.sp,
                    padding: EdgeInsets.only(bottom: 36.sp),
                    child: Column(
                      children: [
                        ButtonBottomNavigated(
                          title: "Tạo nhóm",
                          onPressed: () {},
                        ),
                      ],
                    )))));
  }
}
