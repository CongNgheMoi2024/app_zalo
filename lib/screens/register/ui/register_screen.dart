import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/register/bloc/register_cubit.dart';
import 'package:app_zalo/screens/register/bloc/register_state.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:app_zalo/widget/text_input_picked_day/text_input_picked_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  String? phoneNumber;
  RegisterScreen({super.key, this.phoneNumber});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isNameValid = true;

  String selectedTimeBorn = "";
  int? selectedRadio = 1;
  String? gender;
  String? password;
  bool isPasswordValid = true;
  String? dateOfBirth;
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
                  bottom: 25.sp,
                ),
                height: 55.sp,
                width: width,
                child: Text("Zalo",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold)),
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
                height: 20.sp,
                width: width - 20.sp,
                margin: EdgeInsets.only(left: 20.sp),
                child: Text(name == "" ? "Tên không được để trống" : "",
                    style: text11.textColor.error),
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
                    dateOfBirth =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
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
          height: 140.sp,
          padding: EdgeInsets.only(bottom: 30.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                if (state is SuccessRegisterState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, RouterName.uploadAvatarScreen);
                    context.read<RegisterCubit>().resetState();
                  });
                  return Container();
                } else {
                  return state is LoadingRegisterState
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonBottomNavigated(
                              title: "Tiếp tục",
                              isValidate: name != "" &&
                                      name != null &&
                                      dateOfBirth != "" &&
                                      dateOfBirth != null &&
                                      isPasswordValid &&
                                      password != "" &&
                                      password != null &&
                                      isConfirmPasswordValid &&
                                      newPassword != "" &&
                                      newPassword != null
                                  ? true
                                  : false,
                              onPressed: () async {
                                context.read<RegisterCubit>().register(
                                    widget.phoneNumber!,
                                    name!,
                                    selectedRadio! == 2 ? 0 : 1,
                                    dateOfBirth!,
                                    password!,
                                    newPassword!);
                              },
                            ),
                            state is ErrorRegisterState
                                ? Text(
                                    "Số điện thoại đã đăng kí rồi",
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
      ),
    );
  }
}
