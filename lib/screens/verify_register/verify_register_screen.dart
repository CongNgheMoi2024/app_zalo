import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/widget/appbar/appbar_actions.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyRegisterScreen extends StatefulWidget {
  const VerifyRegisterScreen({super.key});

  @override
  State<VerifyRegisterScreen> createState() => _VerifyRegisterScreenState();
}

class _VerifyRegisterScreenState extends State<VerifyRegisterScreen> {
  bool isValidatedOtp = false;

  TextEditingController? otpController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DismissKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const AppbarActions(
                title: "Đăng kí",
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    SizedBox(
                      height: height * 0.3,
                      child: Center(
                          child: Text(
                        "Xác nhận OTP",
                        style: text24.black.bold,
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.sp, vertical: 20.sp),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: otpController,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.length < 6 && v.isNotEmpty) {
                            return "Mã OTP phải đủ 6 số";
                          } else {
                            isValidatedOtp = true;
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 55.sp,
                          fieldWidth: 45.sp,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.grey.shade200,
                          selectedFillColor: Colors.grey.shade300,
                          activeColor: primaryColor.withOpacity(0.3),
                          activeBorderWidth: 1,
                          selectedColor: greyIcBot.withOpacity(0.3),
                          selectedBorderWidth: 1,
                          inactiveColor: greyIcBot.withOpacity(0.3),
                          inactiveBorderWidth: 1,
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Chưa nhận được? ',
                              style: text15.textColor.regular,
                              children: <TextSpan>[
                            TextSpan(
                              text: 'Gửi lại',
                              style: text15.primary.bold,
                            ),
                          ])),
                    )
                  ])))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 126.sp,
          padding: EdgeInsets.only(bottom: 37.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonBottomNavigated(
                title: "Xác thực",
                onPressed: () {
                  Navigator.pushNamed(context, RouterName.uploadAvatarScreen);
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouterName.loginScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.sp),
                  child: RichText(
                      text: TextSpan(
                          text: "Bạn đã có tài khoản? ",
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
