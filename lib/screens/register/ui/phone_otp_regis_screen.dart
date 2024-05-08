import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/register/bloc/phone_otp_regis_cubit.dart';
import 'package:app_zalo/screens/register/bloc/phone_otp_regis_state.dart';
import 'package:app_zalo/screens/verify_register/bloc/verify_register_cubit.dart';
import 'package:app_zalo/screens/verify_register/verify_register_screen.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneOTPRegisterScreen extends StatefulWidget {
  const PhoneOTPRegisterScreen({super.key});

  @override
  State<PhoneOTPRegisterScreen> createState() => _PhoneOTPRegisterScreenState();
}

class _PhoneOTPRegisterScreenState extends State<PhoneOTPRegisterScreen> {
  String? phoneNumber;
  bool isPhoneNumberValid = true;
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
            top: 115.sp,
            left: 30.sp,
            bottom: 25.sp,
          ),
          height: 55.sp,
          width: width,
          child: Text("Đăng kí Zola", style: text40.semiBold.primary),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 50.sp,
            left: 20.sp,
          ),
          height: 55.sp,
          width: width,
          child: Text("Nhập SĐT để đăng kí", style: text20.semiBold.medium),
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
      ]))),
      bottomNavigationBar: Container(
        height: 140.sp,
        padding: EdgeInsets.only(bottom: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<PhoneOtpRegisCubit, PhoneOtpRegisState>(
                builder: (context, state) {
              if (state is SuccessPhoneOtpRegisState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<VerifyRegisterCubit>(
                        create: (BuildContext context) => VerifyRegisterCubit(),
                        child: VerifyRegisterScreen(
                          phoneNumber: state.phoneNumber,
                        ),
                      ),
                    ),
                  );
                  context.read<PhoneOtpRegisCubit>().resetState();
                });
                return Container();
              } else {
                return state is LoadingPhoneOtpRegisState
                    ? const CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ButtonBottomNavigated(
                            title: "Tiếp tục",
                            isValidate: phoneNumber != "" &&
                                    phoneNumber != null &&
                                    isPhoneNumberValid
                                ? true
                                : false,
                            onPressed: () async {
                              context
                                  .read<PhoneOtpRegisCubit>()
                                  .phoneOtpRegis(phoneNumber!);
                            },
                          ),
                          state is ErrorPhoneOtpRegisState
                              ? Text(
                                  "Số điện thoại đã tồn tại",
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
    ));
  }
}
