import 'package:app_zalo/widget/appbar/appbar_actions.dart';
import 'package:flutter/material.dart';

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({super.key});

  @override
  State<InputNameScreen> createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          AppbarActions(
            title: "Tên",
            actionLeft: () {
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
