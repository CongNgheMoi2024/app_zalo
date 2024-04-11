import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class AppbarActions extends StatefulWidget {
  final Function? actionLeft;
  final String? title;
  final String? icLeft;
  final double? sizeLeft;
  const AppbarActions({
    super.key,
    this.actionLeft,
    this.title,
    this.icLeft,
    this.sizeLeft,
  });

  @override
  State<AppbarActions> createState() => _AppbarActionsState();
}

class _AppbarActionsState extends State<AppbarActions> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.065,
        width: width,
        padding: EdgeInsets.only(
          top: 5.sp,
        ),
        decoration: const BoxDecoration(color: whiteColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
            Expanded(
              child: Center(
                child:
                    Text(widget.title ?? "Tiêu đề", style: text17.medium.black),
              ),
            ),
            SizedBox(
              width: 55.sp,
            )
          ],
        ));
  }
}
