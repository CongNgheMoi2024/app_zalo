import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_actions_bar.dart';
import 'package:flutter/material.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
      HeaderActionsBar(
        icon1: Icons.qr_code_scanner_outlined,
        icon2: Icons.add,
      ),
      Expanded(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: [])))
    ]))));
  }
}
