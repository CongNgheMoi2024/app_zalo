import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/forgot_password/bloc/otp_forgot_cubit.dart';
import 'package:app_zalo/screens/forgot_password/bloc/otp_forgot_state.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpForgotPasswordScreen extends StatefulWidget {
  String? phone;
  OtpForgotPasswordScreen({super.key, this.phone});

  @override
  State<OtpForgotPasswordScreen> createState() =>
      _OtpForgotPasswordScreenState();
}

class _OtpForgotPasswordScreenState extends State<OtpForgotPasswordScreen> {
  bool isValidatedOtp = false;

  String? password;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  String? newPassword;
  TextEditingController? otpController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100.sp,
                  width: width,
                  margin: EdgeInsets.only(top: 150.sp, bottom: 70.sp),
                  child: Center(
                    child: Text(
                      'Nhập mã OTP gửi về máy bạn',
                      style: text22.semiBold.primary,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otpController,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v!.length < 6 && v.isNotEmpty) {
                        isValidatedOtp = false;
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 142.sp,
          padding: EdgeInsets.only(bottom: 33.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<OTPForgotCubit, OTPForgotPasswordState>(
                  builder: (context, state) {
                if (state is SuccessOTPForgotState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, RouterName.loginScreen);
                    context.read<OTPForgotCubit>().resetState();
                  });
                  return Container();
                } else {
                  return state is LoadingOTPForgotPasswordState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ButtonBottomNavigated(
                              title: "Xác nhận",
                              isValidate: isValidatedOtp &&
                                  isPasswordValid &&
                                  isConfirmPasswordValid &&
                                  password != null &&
                                  newPassword != null &&
                                  password != "",
                              onPressed: () {
                                context
                                    .read<OTPForgotCubit>()
                                    .OTPForgotenticate(otpController!.text,
                                        password!, newPassword!, widget.phone!);
                              },
                            ),
                            state is ErrorOTPForgotPasswordState
                                ? Text(
                                    "OTP nhập không đúng, nhập lại đi",
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
