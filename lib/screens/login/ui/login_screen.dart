import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/boarding/boarding_screen.dart';
import 'package:app_zalo/screens/register/ui/register_screen.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:app_zalo/widget/text_input/text_input_password.dart';
import 'package:app_zalo/widget/text_input/text_input_phone.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BoardingScreen()));
            }),
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        toolbarHeight: 48,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 43,
                width: widthMedia,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15.sp),
                child: Text(
                  'Vui lòng nhập số điện thoại và mật khẩu để đăng nhập',
                  style: TextStyle(color: blackColor, fontSize: 13.sp),
                )),
            Container(
              child: Column(
                children: [
                  TextInputLogin(
                    title: 'Tài khoản',
                  ),
                  TextInputPassword(title: 'Mật khẩu',)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
