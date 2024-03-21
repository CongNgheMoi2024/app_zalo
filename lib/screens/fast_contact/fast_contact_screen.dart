import 'dart:async';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class FastContactScreen extends StatefulWidget {
  List<Contact>? contacts = [];
  FastContactScreen({super.key, this.contacts});

  @override
  State<FastContactScreen> createState() => _FastContactScreenState();
}

class _FastContactScreenState extends State<FastContactScreen> {
  String? previousFirstLetter;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
            child: Wrap(
                children: widget.contacts!.asMap().entries.map((entry) {
              final index = entry.key;

              final e = entry.value;
              final firstLetter = "${e.displayName?[0].toUpperCase()}";

              final isFirstLetterSame = firstLetter == previousFirstLetter;

              final shouldShowFirstLetter = !isFirstLetterSame;
              previousFirstLetter = firstLetter;
              return Column(
                children: [
                  if (shouldShowFirstLetter)
                    Regex.number(firstLetter!) == true ||
                            e.displayName!.startsWith("Contact")
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                              left: 10.sp,
                              top: 10.sp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(firstLetter, style: text26.black.bold),
                              ],
                            ),
                          ),
                  Container(
                    height: 65.sp,
                    width: width,
                    padding:
                        EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
                    child: Row(
                      children: [
                        e.avatar != null && e.avatar!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.memory(
                                    height: 46.sp, width: 46.sp, e.avatar!),
                              )
                            : Container(
                                height: 46.sp,
                                width: 46.sp,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                      255,
                                      255,
                                      (231 - (index + 12) % 99),
                                      (211 - index * 3 % 100)),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Center(
                                  child: Text(
                                    e.displayName![0].toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: text22.white.bold.copyWith(
                                        color: Color.fromARGB(255, 0,
                                            (106 - (index * 8) % 98), 122)),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.sp,
                            ),
                            Text(
                                "${e.displayName}" == ""
                                    ? "Chưa đặt tên"
                                    : "${e.displayName}",
                                style: text16.black.medium),
                            SizedBox(
                              height: 2.sp,
                            ),
                            Text(e.phones!.first.value!,
                                style: text16.black.regular),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList()),
          ),
        ),
      ),
    );
  }
}
