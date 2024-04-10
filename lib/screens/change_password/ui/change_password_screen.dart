import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/change_password/bloc/change_password_cubit.dart';
import 'package:app_zalo/screens/change_password/bloc/change_password_state.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/button/button_bottom_next.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  String? phone;
  ChangePasswordScreen({super.key, this.phone});

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? password;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  String? confirmPassword;
  String? newPassword;
  bool isNewPasswordValid = true;
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
                    'Đổi mật khẩu',
                    style: text22.semiBold.primary,
                  ),
                ),
              ),
              TextInputPassword(
                title: "Mật khẩu cũ",
                onChanged: (value) {
                  setState(() {
                    password = value;
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
              TextInputPassword(
                title: "Mật khẩu mới",
                onChanged: (value) {
                  setState(() {
                    newPassword = value;
                    isNewPasswordValid = Regex.password(newPassword!);
                  });
                },
              ),
              Container(
                height: 15.sp,
                width: widthMedia - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    !isNewPasswordValid
                        ? "Phải từ 6 kí tự, có chữ hoa, chữ thường, số và kí tự đặc biệt"
                        : "",
                    style: text11.textColor.error),
              ),
              TextInputPassword(
                title: "Nhập lại Mật khẩu mới",
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                    if (isPasswordValid && confirmPassword != newPassword) {
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
                height: 15.sp,
                width: widthMedia - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(
                    isConfirmPasswordValid == false
                        ? "Mật khẩu nhập lại không đúng"
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
            height: 171.sp,
            padding: EdgeInsets.only(bottom: 25.sp),
            child: Column(
              children: [
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      context.read<ChangePasswordCubit>().resetState();
                    });
                    return Container();
                  } else {
                    return state is LoadingChangePasswordState
                        ? const CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                state is ErrorChangePasswordState
                                    ? Container()
                                    : SizedBox(
                                        width: widthMedia,
                                        height: 17.sp,
                                      ),
                                ButtonBottomNavigated(
                                    title: "Xác nhận",
                                    isValidate: isPasswordValid &&
                                        password != "" &&
                                        isConfirmPasswordValid &&
                                        confirmPassword != "" &&
                                        isNewPasswordValid &&
                                        newPassword != "",
                                    onPressed: () {
                                      context
                                          .read<ChangePasswordCubit>()
                                          .ChangePassword(
                                              password!,
                                              newPassword!,
                                              confirmPassword!,
                                              widget.phone!);
                                    }),
                                state is ErrorChangePasswordState
                                    ? Text(
                                        "Mật khẩu không đúng",
                                        style: text13.medium.error,
                                      )
                                    : Container(),
                              ]);
                  }
                }),
                ButtonBottomNext(
                    title: "Quay lại",
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )),
      ),
    );
  }
}
