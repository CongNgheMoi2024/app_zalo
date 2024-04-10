import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/login/bloc/login_cubit.dart';
import 'package:app_zalo/screens/login/bloc/login_state.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                margin: EdgeInsets.only(top: 150.sp, bottom: 30.sp),
                child: Center(
                  child: Text(
                    'Đăng nhập',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterName.forgotPasswordScreen);
                    },
                    child: Text(
                      "Quên mật khẩu?",
                      style: text14.medium.textColor.primary,
                    ),
                  ),
                  SizedBox(
                    width: 20.sp,
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 142.sp,
          padding: EdgeInsets.only(bottom: 33.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                if (state is LoadingLoginState) {
                  return const CircularProgressIndicator(
                    color: primaryColor,
                  );
                } else if (state is ErrorLoginState) {
                  return Column(
                    children: [
                      SizedBox(
                          height: 63.sp,
                          width: widthMedia,
                          child: Center(
                            child: GestureDetector(
                              onTap: isPhoneNumberValid &&
                                      isPasswordValid &&
                                      passWord != "" &&
                                      passWord != null &&
                                      phoneNumber != "" &&
                                      phoneNumber != null
                                  ? () {
                                      context.read<LoginCubit>().Loginenticate(
                                          phoneNumber!, passWord!);
                                    }
                                  : null,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 55.sp,
                                    right: 55.sp,
                                    bottom: 5.sp,
                                    top: 8.sp),
                                width: widthMedia - 40.sp,
                                decoration: BoxDecoration(
                                    color: isPhoneNumberValid &&
                                            isPasswordValid &&
                                            passWord != "" &&
                                            passWord != null &&
                                            phoneNumber != "" &&
                                            phoneNumber != null
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
                      Text("Thông tin đăng nhập không đúng",
                          style: text11.medium.error)
                    ],
                  );
                } else if (state is LoginenticatedState) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouterName.dashboardScreen, (route) => false);
                    context.read<LoginCubit>().resetState();
                  });
                  return Container();
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 18.sp,
                      ),
                      SizedBox(
                          height: 63.sp,
                          width: widthMedia,
                          child: Center(
                            child: GestureDetector(
                              onTap: isPhoneNumberValid &&
                                      isPasswordValid &&
                                      passWord != "" &&
                                      passWord != null &&
                                      phoneNumber != "" &&
                                      phoneNumber != null
                                  ? () {
                                      context.read<LoginCubit>().Loginenticate(
                                          phoneNumber!, passWord!);
                                    }
                                  : null,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 55.sp,
                                    right: 55.sp,
                                    bottom: 5.sp,
                                    top: 8.sp),
                                width: widthMedia - 40.sp,
                                decoration: BoxDecoration(
                                    color: isPhoneNumberValid &&
                                            isPasswordValid &&
                                            passWord != "" &&
                                            passWord != null &&
                                            phoneNumber != "" &&
                                            phoneNumber != null
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
                    ],
                  );
                }
              }),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RouterName.phoneOTPRegisterScreen);
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
