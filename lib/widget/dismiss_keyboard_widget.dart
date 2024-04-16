
import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  const DismissKeyboard({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget child;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(FocusManager.instance.primaryFocus?.hasFocus ?? false)) return;
        FocusManager.instance.primaryFocus?.unfocus();
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
