import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_state.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForwardMessageScreen extends StatefulWidget {
  const ForwardMessageScreen({super.key});

  @override
  State<ForwardMessageScreen> createState() => _ForwardMessageScreenState();
}

class _ForwardMessageScreenState extends State<ForwardMessageScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllRoomCubit>(context).getAllRoomsUser();
  }

  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DismissKeyboard(child: SafeArea(child: Scaffold(body:
        BlocBuilder<GetAllRoomCubit, GetAllRoomState>(
            builder: (context, state) {
      if (state is GetAllRoomSuccessState) {
        print("Data ${state.data}");
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.sp,
          ),
          TextInputLogin(
            title: "Tìm kiếm",
            onChanged: (value) {
              print(value);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                print("Refreshed");
              },
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: state is LoadingGetAllRoomState
                      ? SizedBox(
                          height: height,
                          width: width,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : state is GetAllRoomSuccessState
                          ? Wrap(
                              children: state.data.asMap().entries.map<Widget>(
                              (entry) {
                                print("Entry ${entry.value.userRecipient.sex}");
                                DateTime messageTime = DateTime.parse(
                                    entry.value.lastMessage.timestamp);

                                Duration difference =
                                    DateTime.now().difference(messageTime);
                                String timeAgoText = '';
                                if (difference.inDays > 0) {
                                  timeAgoText =
                                      '${difference.inDays} ngày trước';
                                } else if (difference.inHours > 0) {
                                  timeAgoText =
                                      '${difference.inHours} giờ trước';
                                } else if (difference.inMinutes > 0) {
                                  timeAgoText =
                                      '${difference.inMinutes} phút trước';
                                } else {
                                  timeAgoText = 'vừa mới';
                                }
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.sp,
                                                  right: 10.sp,
                                                  top: 12.sp,
                                                  bottom: 12.sp),
                                              child: Checkbox(
                                                value: isCheck,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isCheck = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 20.sp,
                                                  top: 12.sp,
                                                  bottom: 12.sp),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: entry.value.userRecipient.avatar == "" &&
                                                        entry.value.userRecipient
                                                                .sex ==
                                                            true
                                                    ? ImageAssets.pngAsset(
                                                        Png.imgUserBoy,
                                                        width: 35.sp,
                                                        height: 35.sp,
                                                        fit: BoxFit.cover)
                                                    : entry.value.userRecipient.avatar == "" &&
                                                            entry
                                                                    .value
                                                                    .userRecipient
                                                                    .sex ==
                                                                false
                                                        ? ImageAssets.pngAsset(
                                                            Png.imgUserGirl,
                                                            width: 35.sp,
                                                            height: 35.sp,
                                                            fit: BoxFit.cover)
                                                        : ImageAssets.networkImage(
                                                            url: entry
                                                                .value
                                                                .userRecipient
                                                                .avatar,
                                                            width: 35.sp,
                                                            height: 35.sp,
                                                            fit: BoxFit.cover),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                entry.value.userRecipient.name,
                                                style: text16.black.medium,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.sp),
                                              child: Text(
                                                timeAgoText,
                                                style: text15.regular.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 0.5.sp,
                                        width: width,
                                        color: grey03.withOpacity(0.5),
                                        margin: EdgeInsets.only(left: 105.sp),
                                      )
                                    ]);
                              },
                            ).toList())
                          : Container()),
            ),
          ),
        ],
      );
    }))));
  }
}
