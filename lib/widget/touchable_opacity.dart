import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final Widget child;

  const TouchableOpacity({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: (a) {
        setState(() {
          enable = true;
        });
      },
      onTapUp: (a) {
        setState(() {
          enable = false;
        });
      },
      onTapCancel: () {
        setState(() {
          enable = false;
        });
      },
      child: Opacity(opacity: enable ? 0.5 : 1, child: widget.child),
    );
  }
}
