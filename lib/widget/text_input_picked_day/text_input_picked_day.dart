import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputPickedDay extends StatefulWidget {
  String? day;
  String? hint;
  Function? onChanged;
  Function(String)? onManualInput;
  TextInputPickedDay({
    super.key,
    this.day,
    this.hint,
    this.onChanged,
    this.onManualInput,
  });

  @override
  State<TextInputPickedDay> createState() => _TextInputPickedDayState();
}

class _TextInputPickedDayState extends State<TextInputPickedDay> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.day);
  }

  @override
  void didUpdateWidget(covariant TextInputPickedDay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.day != widget.day) {
      _controller.text = widget.day ?? "";
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002, 11, 30),
      firstDate: DateTime(1970),
      lastDate: DateTime(2018),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      widget.onChanged!(picked);
      widget.onManualInput!(picked.toIso8601String());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 56.sp,
          margin: EdgeInsets.only(
            left: 20.sp,
            right: 20.sp,
          ),
          child: TextField(
            controller: _controller,
            cursorColor: greyIcTop,
            decoration: InputDecoration(
              label: Text(
                widget.hint!,
                style:
                    text15.regular.copyWith(color: greyIcTop.withOpacity(0.6)),
              ),
              hintText: widget.hint!,
              hintStyle: text16.copyWith(color: greyIcTop.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: greyIcTop.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: greyIcTop.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
            ),
            onChanged: (text) {
              widget.onManualInput!(text);
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
                margin: EdgeInsets.only(right: 20.sp),
                width: 65.sp,
                height: 56.sp,
                alignment: const Alignment(0, 0),
                child: Icon(Icons.calendar_month_outlined, size: 20.sp)),
          ),
        ),
      ],
    );
  }
}
