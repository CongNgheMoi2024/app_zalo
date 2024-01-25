import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
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
  String selectedTimeBorn = "";
  int? selectedRadio;

  String? gender;
  String? dateOfBirth;
  String? phoneNumber;
  String? name;
  String? address;

  late TextEditingController lastNameController;
  late TextEditingController firstNameController;
  late TextEditingController? introductionController;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                top: 110.sp,
                left: 30.sp,
              ),
              height: 55.sp,
              width: width,
              child: Text("Zalo",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold)),
            ),
            TextInputWidget(
              title: "Số điện thoại",
              value: phoneNumber,
              onTextChanged: (text) {
                setState(() {
                  phoneNumber = text;
                });
              },
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
            TextInputPassword(
              title: "Mật khẩu",
              onChanged: () {},
            ),
            TextInputPassword(
              title: "Nhập lại Mật khẩu",
              onChanged: () {},
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.sp,
        padding: EdgeInsets.only(bottom: 37.sp),
        child: ButtonBottomNavigated(
          title: "Đăng ký",
          onPressed: () {},
        ),
      ),
    );
  }
}
