import 'dart:math';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/models/chat/infor_user_chat.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/ui/chatting_with_screen.dart';
import 'package:app_zalo/screens/fast_contact/bloc/acept_friend.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_state.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_requests_friend.dart';
import 'package:app_zalo/utils/regex.dart';
import 'package:app_zalo/widget/async_phonebook/async_phonebook.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class FastContactScreen extends StatefulWidget {
  List<Contact>? contacts = [];
  FastContactScreen({super.key, this.contacts});

  @override
  State<FastContactScreen> createState() => _FastContactScreenState();
}

class _FastContactScreenState extends State<FastContactScreen> {
  String? previousFirstLetter1;
  String? previousFirstLetter2;

  int _currentIndex = 0;

  @override
  initState() {
    super.initState();
    context.read<FastContactCubit>().FastContactenticate();
    context.read<GetFriendsCubit>().getFriendsPhoneBook();
  }

  void showSnackBar(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã chấp nhận lời mời kết bạn'),
      ),
    );
  }

  List<UserRequest>? list = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    context.read<FastContactCubit>().FastContactenticate();
    context.read<GetFriendsCubit>().getFriendsPhoneBook();

    return DismissKeyboard(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AsyncPhonebook(
              contacts: widget.contacts,
            ),
            FutureBuilder<List<UserRequest>>(
                future: GetRequestFriend().getRequestFriend(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    list = snapshot.data;

                    return Wrap(
                        children: list!.asMap().entries.map<Widget>((entry) {
                      return Container(
                        margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                        height: 55.sp,
                        width: width,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(Png.imgUserGirl),
                            ),
                            SizedBox.fromSize(
                              size: Size.fromWidth(30.sp),
                            ),
                            Expanded(child: Text(entry.value.name ?? "")),
                            InkWell(
                              onTap: () async {
                                final result = await AcceptFriend()
                                    .acceptFriend(entry.value.idUser!);

                                if (result) {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context);
                                  setState(() {
                                    list!.removeAt(entry.key);
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 7.sp),
                                child: Text("Chấp nhận",
                                    style: text15.regular
                                        .copyWith(color: greenDC)),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: Icon(
                                  Icons.close_sharp,
                                  size: 25.sp,
                                  color: errorColor.withOpacity(0.8),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList());
                  }
                }),
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
              child: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                      margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                      child: IndexedStack(index: _currentIndex, children: [
                        BlocBuilder<FastContactCubit, FastContactState>(
                            builder: (context, stateFastContact) {
                          return stateFastContact
                                  is FastContactFriendsSuccessdState
                              ? Wrap(
                                  children: stateFastContact.data
                                      .asMap()
                                      .entries
                                      .map<Widget>((entry) {
                                    final data = entry.value;

                                    final firstLetter =
                                        data.name[0].toUpperCase().toString();

                                    final isFirstLetterSame =
                                        firstLetter == previousFirstLetter1;

                                    final shouldShowFirstLetter =
                                        !isFirstLetterSame;
                                    previousFirstLetter1 = firstLetter;
                                    return Column(
                                      children: [
                                        if (shouldShowFirstLetter)
                                          Regex.number(firstLetter) == true ||
                                                  data.name
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
                                                          style: text26
                                                              .black.bold),
                                                    ],
                                                  ),
                                                ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BlocProvider<
                                                            GetAllMessageCubit>(
                                                        create: (BuildContext
                                                                context) =>
                                                            GetAllMessageCubit(),
                                                        child:
                                                            ChattingWithScreen(
                                                          inforUserChat:
                                                              InforUserChat(
                                                            idUserRecipient:
                                                                data.id,
                                                            name: data.name,
                                                            avatar: data.avatar,
                                                            timeActive:
                                                                "1 phút trước",
                                                            sex: true,
                                                            members: [],
                                                            isGroup: false,
                                                            idGroup: "",
                                                          ),
                                                        ))));
                                          },
                                          child: Container(
                                            height: 65.sp,
                                            width: width,
                                            padding: EdgeInsets.only(
                                                top: 10.sp,
                                                left: 10.sp,
                                                right: 10.sp),
                                            child: Row(
                                              children: [
                                                data.avatar.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child: ImageAssets
                                                            .networkImage(
                                                                height: 46.sp,
                                                                width: 46.sp,
                                                                url: data
                                                                    .avatar),
                                                      )
                                                    : Container(
                                                        height: 46.sp,
                                                        width: 46.sp,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              131 +
                                                                  Random()
                                                                      .nextInt(
                                                                          100),
                                                              122 +
                                                                  Random()
                                                                      .nextInt(
                                                                          70)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(60),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            data.name[0]
                                                                .toUpperCase(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: text22.white.bold.copyWith(
                                                                color: Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    106 +
                                                                        Random().nextInt(
                                                                            100) +
                                                                        1,
                                                                    122 +
                                                                        Random()
                                                                            .nextInt(40))),
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
                                                    Text(data.name,
                                                        style: text16
                                                            .black.medium),
                                                    SizedBox(
                                                      height: 2.sp,
                                                    ),
                                                    Text(data.phone,
                                                        style: text16
                                                            .black.regular),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                )
                              : stateFastContact is LoadingFastContactState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : stateFastContact is ErrorFastContactState
                                      ? Center(
                                          child: Text("Lỗi khi tải dữ liệu",
                                              style: text16.error.regular),
                                        )
                                      : Center(
                                          child: Text("Không có dữ liệu",
                                              style: text16.primary.regular),
                                        );
                        }),
                        BlocBuilder<GetFriendsCubit, GetFriendsState>(
                            builder: (context, stateGetFriends) {
                          return stateGetFriends
                                  is GetFriendsPhoneBookSuccessState
                              ? Wrap(
                                  children: stateGetFriends.data
                                      .asMap()
                                      .entries
                                      .map<Widget>((entry) {
                                    final data = entry.value;

                                    final firstLetter = data["name"]![0]
                                        .toUpperCase()
                                        .toString();

                                    final isFirstLetterSame =
                                        firstLetter == previousFirstLetter2;

                                    final shouldShowFirstLetter =
                                        !isFirstLetterSame;
                                    previousFirstLetter2 = firstLetter;
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
                                                          style: text26
                                                              .black.bold),
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
                                                          BorderRadius.circular(
                                                              60),
                                                      child: ImageAssets
                                                          .networkImage(
                                                        url: data["avatar"]!,
                                                        height: 46.sp,
                                                        width: 46.sp,
                                                      ),
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
                                                                    .nextInt(
                                                                        100),
                                                            122 +
                                                                Random()
                                                                    .nextInt(
                                                                        70)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
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
                                                                      Random().nextInt(
                                                                          100) +
                                                                      1,
                                                                  122 +
                                                                      Random().nextInt(
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
                                                      style:
                                                          text16.black.medium),
                                                  SizedBox(
                                                    height: 2.sp,
                                                  ),
                                                  Text(data["phone"],
                                                      style:
                                                          text16.black.regular),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                )
                              : stateGetFriends
                                      is LoadingGetFriendsPhoneBookState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : stateGetFriends
                                          is ErrorGetFriendsPhoneBookState
                                      ? Center(
                                          child: Text("Lỗi khi tải dữ liệu",
                                              style: text16.error.regular),
                                        )
                                      : Center(
                                          child: Text("Không có dữ liệu",
                                              style: text16.primary.regular),
                                        );
                        })
                      ])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
