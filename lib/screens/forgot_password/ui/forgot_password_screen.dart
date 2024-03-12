import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? phoneNumber;
  bool isPhoneNumberValid = false;
  @override
  Widget build(BuildContext context) {
    double widthMedia = MediaQuery.of(context).size.width;
    return DismissKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 100.sp,
                width: widthMedia,
                margin: EdgeInsets.only(top: 150.sp, bottom: 80.sp),
                child: Center(
                  child: Text(
                    'Quên mật khẩu?',
                    style: text22.semiBold.primary,
                  ),
                ),
              ),
              TextInputLogin(
                title: 'Số điện thoại',
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone;
                    isPhoneNumberValid = Regex.isPhone(phoneNumber!);
                  });
                },
              ),
              Container(
                width: widthMedia - 20.sp,
                height: 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                  isPhoneNumberValid == false &&
                          phoneNumber != null &&
                          phoneNumber != ""
                      ? "Số điện thoại không hợp lệ!"
                      : "",
                  style: text11.textColor.error,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 142.sp,
          padding: EdgeInsets.only(bottom: 33.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 63.sp,
                width: widthMedia,
                child: Container(
                  margin: EdgeInsets.only(
                      left: 55.sp, right: 55.sp, bottom: 5.sp, top: 8.sp),
                  width: widthMedia - 40.sp,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(28.sp)),
                  child: Center(
                    child: Text(
                      "Tiếp tục",
                      style: text15.medium.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouterName.loginScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.sp),
                  child: RichText(
                      text: TextSpan(
                          text: "Bạn có muốn quay lại ",
                          style: text14.regular.black,
                          children: [
                        TextSpan(
                          text: "Đăng nhập",
                          style: text14.semiBold.primary,
                        )
                      ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
