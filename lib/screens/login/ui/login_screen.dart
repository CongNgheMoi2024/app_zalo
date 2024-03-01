import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/boarding/boarding_screen.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phoneNumber;
  String? passWord;
  bool isPhoneNumberValid = false;
  bool isButtonEnable = false;
  bool isPasswordValid = true;
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
                margin: EdgeInsets.only(top: 130.sp, bottom: 10.sp),
                child: Center(
                  child: Text(
                    'Đăng nhập',
                    style: text22.medium.primary,
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
              TextInputPassword(
                title: 'Mật khẩu',
                onChanged: (password) {
                  setState(() {
                    passWord = password;
                    isPasswordValid = Regex.password(password!);
                  });
                },
              ),
              Container(
                height: 15.sp,
                width: widthMedia - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    !isPasswordValid
                        ? "Phải từ 6 kí tự, có chữ hoa, chữ thường, số và kí tự đặc biệt"
                        : "",
                    style: text11.textColor.error),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 126.sp,
          padding: EdgeInsets.only(bottom: 37.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 63.sp,
                  width: widthMedia,
                  child: Center(
                    child: GestureDetector(
                      onTap: isPhoneNumberValid && isPasswordValid
                          ? () {
                              Navigator.pushNamed(
                                  context, RouterName.uploadAvatarScreen);
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 55.sp, right: 55.sp, bottom: 5.sp, top: 8.sp),
                        width: widthMedia - 40.sp,
                        decoration: BoxDecoration(
                            color: isPhoneNumberValid
                                ? primaryColor
                                : primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(28.sp)),
                        child: Center(
                          child: Text(
                            "Đăng nhập",
                            style: text15.medium.white,
                          ),
                        ),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouterName.registerScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.sp),
                  child: RichText(
                      text: TextSpan(
                          text: "Bạn chưa có tài khoản? ",
                          style: text14.regular.black,
                          children: [
                        TextSpan(
                          text: "Đăng ký",
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
