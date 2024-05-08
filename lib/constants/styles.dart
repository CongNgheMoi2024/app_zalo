import 'package:flutter/material.dart';

import 'index.dart';

TextStyle get fontApp => TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      color: Colors.black,
      decoration: TextDecoration.none,
    );

TextStyle get text10 => fontApp.copyWith(fontSize: 10.sp);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.sp);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.sp);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.sp);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.sp);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.sp);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.sp);

TextStyle get text17 => fontApp.copyWith(fontSize: 17.sp);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.sp);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.sp);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.sp);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.sp);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.sp);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.sp);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.sp);

TextStyle get text32 => fontApp.copyWith(fontSize: 32.sp);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.sp);

TextStyle get text38 => fontApp.copyWith(fontSize: 38.sp);

TextStyle get text40 => fontApp.copyWith(fontSize: 40.sp);

TextStyle get text48 => fontApp.copyWith(fontSize: 48.sp);

TextStyle get text50 => fontApp.copyWith(fontSize: 50.sp);

TextStyle get text52 => fontApp.copyWith(fontSize: 52.sp);

TextStyle get text60 => fontApp.copyWith(fontSize: 60.sp);

TextStyle get text65 => fontApp.copyWith(fontSize: 65.sp);

TextStyle get text80 => fontApp.copyWith(fontSize: 80.sp);

TextStyle get text100 => fontApp.copyWith(fontSize: 100.sp);

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get underLine => copyWith(decoration: TextDecoration.underline);

  TextStyle get overLine => copyWith(decoration: TextDecoration.overline);

  TextStyle get thickNess2 => copyWith(decorationThickness: 2);

  //Weight style
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get bold800 => copyWith(fontWeight: FontWeight.w800);

  //height style
  TextStyle get height0_22Per => copyWith(height: 0.22);

  TextStyle get height17Per => copyWith(height: 1.7);

  TextStyle get height18Per => copyWith(height: 1.8);

  TextStyle get height19Per => copyWith(height: 1.9);

  TextStyle get height20Per => copyWith(height: 2.0);

  TextStyle get height21Per => copyWith(height: 2.1);

  TextStyle get height22Per => copyWith(height: 2.2);

  //Color style
  TextStyle get black => copyWith(color: blackColor);
  TextStyle get textColor => copyWith(color: greyIcBot);
  TextStyle get primary => copyWith(color: primaryColor);
  TextStyle get error => copyWith(color: Colors.red);
  TextStyle get white => copyWith(color: whiteColor);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle get bgColor =>
      copyWith(color: const Color.fromARGB(255, 45, 45, 45));
}
