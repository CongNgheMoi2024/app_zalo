import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:app_zalo/screens/forgot_password/bloc/forgot_password_state.dart';
import 'package:app_zalo/screens/forgot_password/bloc/otp_forgot_cubit.dart';
import 'package:app_zalo/screens/forgot_password/ui/otp_forgot_password_screen.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                if (state is ForgotPasswordenticatedState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<OTPForgotCubit>(
                          create: (BuildContext context) => OTPForgotCubit(),
                          child: OtpForgotPasswordScreen(
                            phone: phoneNumber!,
                          ),
                        ),
                      ),
                    );

                    context.read<ForgotPasswordCubit>().resetState();
                  });
                  return Container();
                } else {
                  return state is LoadingForgotPasswordState
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ButtonBottomNavigated(
                                title: "Tiếp tục",
                                isValidate: isPhoneNumberValid &&
                                    phoneNumber != null &&
                                    phoneNumber != "",
                                onPressed: () {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .ForgotPasswordenticate(phoneNumber!);
                                }),
                            state is ErrorForgotPasswordState
                                ? Text(
                                    "Số điện thoại không hợp lệ",
                                    style: text14.medium.error,
                                  )
                                : Container(),
                          ],
                        );
                }
              }),
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
