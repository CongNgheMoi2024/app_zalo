import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/models/chat/infor_user_chat.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/ui/chatting_with_screen.dart';
import 'package:app_zalo/screens/forward/bloc/forward_message_cubit.dart';
import 'package:app_zalo/screens/forward/bloc/forward_message_state.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_state.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ForwardMessageScreen extends StatefulWidget {
  String? idMessage;
  String? idReceiver;
  ForwardMessageScreen({super.key, this.idMessage, this.idReceiver});

  @override
  State<ForwardMessageScreen> createState() => _ForwardMessageScreenState();
}

class _ForwardMessageScreenState extends State<ForwardMessageScreen> {
  String? filter = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllRoomCubit>(context).getAllRoomsUser();
  }

  InforUserChat? inforUserChat;
  List<bool> listChecked = [];
  List<String> listIdRecipient = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DismissKeyboard(
        child: SafeArea(
            child: Scaffold(
                body: BlocBuilder<GetAllRoomCubit, GetAllRoomState>(
                    builder: (context, state) {
                  if (state is GetAllRoomSuccessState) {}
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.sp,
                      ),
                      TextInputWidget(
                        title: "Nhập tên bạn bè cần chuyển tiếp",
                        onTextChanged: (value) {
                          setState(() {
                            filter = value;
                          });
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
                                          children: state.data
                                              .where((element) => element
                                                  .userRecipient.name
                                                  .toLowerCase()
                                                  .contains(
                                                      filter!.toLowerCase()))
                                              .toList()
                                              .asMap()
                                              .entries
                                              .map<Widget>(
                                          (entry) {
                                            DateTime messageTime =
                                                DateTime.parse(entry.value
                                                    .lastMessage.timestamp);

                                            Duration difference = DateTime.now()
                                                .difference(messageTime);
                                            String timeAgoText = '';
                                            if (difference.inDays > 0) {
                                              timeAgoText =
                                                  '${difference.inDays} ngày trước';
                                            } else if (difference.inHours > 0) {
                                              timeAgoText =
                                                  '${difference.inHours} giờ trước';
                                            } else if (difference.inMinutes >
                                                0) {
                                              timeAgoText =
                                                  '${difference.inMinutes} phút trước';
                                            } else {
                                              timeAgoText = 'vừa mới';
                                            }
                                            if (entry.value.userRecipient
                                                    .idRecipient ==
                                                widget.idReceiver) {
                                              inforUserChat = InforUserChat(
                                                  idUserRecipient: entry
                                                      .value
                                                      .userRecipient
                                                      .idRecipient,
                                                  name: entry
                                                      .value.userRecipient.name,
                                                  avatar: entry.value
                                                      .userRecipient.avatar,
                                                  timeActive: timeAgoText,
                                                  sex: entry
                                                      .value.userRecipient.sex,
                                                  members: []);
                                            }

                                            List.generate(state.data.length,
                                                (index) {
                                              listChecked.add(false);
                                            });

                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15.sp,
                                                                  right: 10.sp,
                                                                  top: 12.sp,
                                                                  bottom:
                                                                      12.sp),
                                                          child: Checkbox(
                                                            value: listChecked[
                                                                entry.key],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                listChecked[entry
                                                                        .key] =
                                                                    value!;
                                                                if (value) {
                                                                  listIdRecipient.add(state
                                                                      .data[entry
                                                                          .key]
                                                                      .userRecipient
                                                                      .idRecipient);
                                                                } else {
                                                                  listIdRecipient.remove(state
                                                                      .data[entry
                                                                          .key]
                                                                      .userRecipient
                                                                      .idRecipient);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20.sp,
                                                                  top: 12.sp,
                                                                  bottom:
                                                                      12.sp),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            child: entry.value.userRecipient.avatar == "" &&
                                                                    entry.value.userRecipient.sex ==
                                                                        true
                                                                ? ImageAssets.pngAsset(Png.imgUserBoy,
                                                                    width:
                                                                        35.sp,
                                                                    height:
                                                                        35.sp,
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : entry.value.userRecipient.avatar == "" &&
                                                                        entry.value.userRecipient.sex ==
                                                                            false
                                                                    ? ImageAssets.pngAsset(Png.imgUserGirl,
                                                                        width: 35
                                                                            .sp,
                                                                        height: 35
                                                                            .sp,
                                                                        fit: BoxFit
                                                                            .cover)
                                                                    : ImageAssets.networkImage(
                                                                        url: entry.value.userRecipient.avatar,
                                                                        width: 35.sp,
                                                                        height: 35.sp,
                                                                        fit: BoxFit.cover),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            entry
                                                                .value
                                                                .userRecipient
                                                                .name,
                                                            style: text16
                                                                .black.medium,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20.sp),
                                                          child: Text(
                                                            timeAgoText,
                                                            style: text15
                                                                .regular
                                                                .textColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 0.5.sp,
                                                    width: width,
                                                    color:
                                                        grey03.withOpacity(0.5),
                                                    margin: EdgeInsets.only(
                                                        left: 105.sp),
                                                  )
                                                ]);
                                          },
                                        ).toList())
                                      : Container()),
                        ),
                      ),
                    ],
                  );
                }),
                bottomNavigationBar: Container(
                  height: 100.sp,
                  padding: EdgeInsets.only(bottom: 36.sp),
                  child: BlocBuilder<ForwardMessageCubit, ForwardMessageState>(
                      builder: (context, state) {
                    if (state is ForwardSuccessState) {
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider<GetAllMessageCubit>(
                                        create: (BuildContext context) =>
                                            GetAllMessageCubit(),
                                        child: ChattingWithScreen(
                                          inforUserChat: inforUserChat!,
                                        ))));
                      });
                      return const SizedBox();
                    } else if (state is LoadingForwardMessageState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          ButtonBottomNavigated(
                            title: "Chuyển tiếp",
                            onPressed: () {
                              BlocProvider.of<ForwardMessageCubit>(context)
                                  .forwardMessageenticate(
                                      listIdRecipient, widget.idMessage!);
                            },
                          ),
                        ],
                      );
                    }
                  }),
                ))));
  }
}
