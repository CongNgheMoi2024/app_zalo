import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';

import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:app_zalo/widget/text_input_picked_day/text_input_picked_day.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPhoneNumberValid = true;
  bool isPasswordValid = true;
  String selectedTimeBorn = "";
  int? selectedRadio = 1;
  String? gender;
  String? password;
  String? dateOfBirth;
  String? phoneNumber;
  String? name;
  bool isConfirmPasswordValid = true;
  String? newPassword;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                  top: 105.sp,
                  left: 30.sp,
                  bottom: 20.sp,
                ),
                height: 55.sp,
                width: width,
                child: Text("Zalo",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold)),
              ),
              TextInputLogin(
                title: "Số điện thoại",
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                    isPhoneNumberValid = Regex.isPhone(phoneNumber!);
                  });
                },
              ),
              Container(
                height: 20.sp,
                width: width - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    !isPhoneNumberValid && phoneNumber != ""
                        ? "Số điện thoại không hợp lệ"
                        : "",
                    style: text11.textColor.error),
              ),
              TextInputWidget(
                title: "Tên",
                value: name,
                onTextChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              onChanged: (index) {
                                setState(() {
                                  selectedRadio = index;
                                  gender = 'Nam';
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                'Nam',
                                style: text14.semiBold.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectedRadio,
                              onChanged: (index) {
                                setState(() {
                                  selectedRadio = index;
                                  gender = 'Nữ';
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            Expanded(
                                child: Text(
                              'Nữ',
                              style: text14.semiBold.black,
                            ))
                          ],
                        ),
                      ),
                    ]),
              ),
              TextInputPickedDay(
                day: selectedTimeBorn,
                hint: "Ngày sinh",
                onChanged: (DateTime pickedDate) {
                  setState(() {
                    selectedTimeBorn =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                    dateOfBirth = pickedDate.toIso8601String();
                  });
                },
                onManualInput: (String pickedDate) {
                  setState(() {
                    dateOfBirth = pickedDate;
                  });
                },
              ),
              SizedBox(height: 20.sp),
              TextInputPassword(
                title: "Mật khẩu",
                onChanged: (value) {
                  setState(() {
                    password = value;
                    isPasswordValid = Regex.password(password!);
                  });
                },
              ),
              Container(
                height: 15.sp,
                width: width - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    !isPasswordValid
                        ? "Phải từ 6 kí tự, có chữ hoa, chữ thường, số và kí tự đặc biệt"
                        : "",
                    style: text11.textColor.error),
              ),
              TextInputPassword(
                title: "Nhập lại Mật khẩu",
                onChanged: (value) {
                  setState(() {
                    newPassword = value;
                    if (isPasswordValid && newPassword != password) {
                      setState(() {
                        isConfirmPasswordValid = false;
                      });
                    } else {
                      setState(() {
                        isConfirmPasswordValid = true;
                      });
                    }
                  });
                },
              ),
              Container(
                height: 25.sp,
                width: width - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    isConfirmPasswordValid == false
                        ? "Mật khẩu nhập lại không đúng"
                        : "",
                    style: text11.textColor.error),
              ),
              SizedBox(height: 20.sp)
            ]),
          ),
        ),
        bottomNavigationBar: Container(
          height: 126.sp,
          padding: EdgeInsets.only(bottom: 37.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonBottomNavigated(
                title: "Tiếp tục",
                onPressed: () {
                  Navigator.pushNamed(context, RouterName.verifyRegisterScreen);
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
