import 'dart:async';
import 'dart:math';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/async_phonebook/async_phonebook.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';

class FastContactScreen extends StatefulWidget {
  List<Contact>? contacts = [];
  FastContactScreen({super.key, this.contacts});

  @override
  State<FastContactScreen> createState() => _FastContactScreenState();
}

class _FastContactScreenState extends State<FastContactScreen> {
  String? previousFirstLetter;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DismissKeyboard(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AsyncPhonebook(
              contacts: widget.contacts,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.sp, top: 10.sp, right: 15.sp, bottom: 5.sp),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (_currentIndex != 0) {
                        setState(() {
                          _currentIndex = 0;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 11.sp, vertical: 6.sp),
                      decoration: BoxDecoration(
                        color: _currentIndex == 0
                            ? lightBlue.withOpacity(0.5)
                            : whiteColor,
                        borderRadius: BorderRadius.circular(13.sp),
                        border: Border.all(
                            color: _currentIndex == 0
                                ? Colors.transparent
                                : lightBlue.withOpacity(0.5),
                            width: 1.sp),
                      ),
                      child: Text("Bạn bè",
                          style: text15.black.semiBold.copyWith(
                              color: _currentIndex == 0
                                  ? whiteColor
                                  : lightBlue.withOpacity(0.8))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_currentIndex != 1) {
                        setState(() {
                          _currentIndex = 1;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15.sp),
                      padding: EdgeInsets.symmetric(
                          horizontal: 11.sp, vertical: 6.sp),
                      decoration: BoxDecoration(
                        color: _currentIndex == 1
                            ? lightBlue.withOpacity(0.5)
                            : whiteColor,
                        borderRadius: BorderRadius.circular(13.sp),
                        border: Border.all(
                            color: _currentIndex == 1
                                ? Colors.transparent
                                : lightBlue.withOpacity(0.5),
                            width: 1.sp),
                      ),
                      child: Text("Danh bạ",
                          style: text15.black.semiBold.copyWith(
                              color: _currentIndex == 1
                                  ? whiteColor
                                  : lightBlue.withOpacity(0.8))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                  child: BlocBuilder<FastContactCubit, FastContactState>(
                      builder: (context, state) {
                    if (state is InitialFastContactState) {
                      context.read<FastContactCubit>().FastContactenticate();
                    }
                    return IndexedStack(index: _currentIndex, children: [
                      state is FastContactFriendsSuccessdState
                          ? Wrap(
                              children: state.data
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                final index = entry.key;
                                final data = entry.value;

                                final firstLetter =
                                    data["name"]![0].toUpperCase().toString();

                                final isFirstLetterSame =
                                    firstLetter == previousFirstLetter;

                                final shouldShowFirstLetter =
                                    !isFirstLetterSame;
                                previousFirstLetter = firstLetter;
                                return Column(
                                  children: [
                                    if (shouldShowFirstLetter)
                                      Regex.number(firstLetter) == true ||
                                              data["name"]!
                                                  .startsWith("Contact")
                                          ? Container()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.sp,
                                                top: 10.sp,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(firstLetter,
                                                      style: text26.black.bold),
                                                ],
                                              ),
                                            ),
                                    Container(
                                      height: 65.sp,
                                      width: width,
                                      padding: EdgeInsets.only(
                                          top: 10.sp,
                                          left: 10.sp,
                                          right: 10.sp),
                                      child: Row(
                                        children: [
                                          data["avatar"] != null &&
                                                  data["avatar"]!.isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Image.memory(
                                                      height: 46.sp,
                                                      width: 46.sp,
                                                      data["avatar"]!),
                                                )
                                              : Container(
                                                  height: 46.sp,
                                                  width: 46.sp,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        131 +
                                                            Random()
                                                                .nextInt(100),
                                                        122 +
                                                            Random()
                                                                .nextInt(70)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data["name"]![0]
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: text22.white.bold.copyWith(
                                                          color: Color.fromARGB(
                                                              255,
                                                              0,
                                                              106 +
                                                                  Random()
                                                                      .nextInt(
                                                                          100) +
                                                                  1,
                                                              122 +
                                                                  Random()
                                                                      .nextInt(
                                                                          40))),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 1.sp,
                                              ),
                                              Text(
                                                  data["name"] ??
                                                      "Chưa đặt tên",
                                                  style: text16.black.medium),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Text(data["phone"],
                                                  style: text16.black.regular),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            )
                          : state is LoadingFastContactState
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : state is ErrorFastContactState
                                  ? Center(
                                      child: Text("Lỗi khi tải dữ liệu",
                                          style: text16.error.regular),
                                    )
                                  : Center(
                                      child: Text("Không có dữ liệu",
                                          style: text16.primary.regular),
                                    ),
                      Text("Danh bạ")
                    ]);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
