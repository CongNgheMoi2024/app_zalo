import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/touchable_opacity.dart';
import 'package:flutter/material.dart';

class AppbarActions extends StatefulWidget {
  final Function? actionLeft;
  final Function? actionRight;
  final String? title;
  final String? icLeft;
  final IconData? icRight;
  final double? sizeLeft;
  final double? sizeRight;
  final Color? colorIcRight;
  const AppbarActions(
      {super.key,
      this.actionLeft,
      this.actionRight,
      this.title,
      this.icLeft,
      this.icRight,
      this.sizeLeft,
      this.sizeRight,
      this.colorIcRight});

  @override
  State<AppbarActions> createState() => _AppbarActionsState();
}

class _AppbarActionsState extends State<AppbarActions> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.09,
        width: width,
        decoration: BoxDecoration(color: whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                widget.actionLeft == null
                    ? Navigator.pop(context)
                    : widget.actionLeft!();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                ),
              ),
            ),
            Center(
              child:
                  Text(widget.title ?? "Tiêu đề", style: text17.medium.black),
            ),
            widget.icRight != null
                ? TouchableOpacity(
                    onTap: widget.actionRight,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Icon(widget.icRight,
                            color: (widget.colorIcRight ?? primaryColor),
                            size: 24.sp)),
                  )
                : SizedBox(
                    height: 24.sp + 16,
                    width: 24.sp + 30,
                  ),
          ],
        ));
  }
}
