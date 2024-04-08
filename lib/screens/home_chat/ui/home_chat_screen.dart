import 'dart:convert';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  String idUser = HiveStorage().idUser;
  late StompClient client;

  @override
  void initState() {
    super.initState();
    client = StompClient(
        config: StompConfig.sockJS(
      url: '${Env.url}/ws',
      onConnect: (StompFrame frame) {
        client.subscribe(
            destination: "/user/$idUser/queue/messages",
            callback: (StompFrame frame) {
              print("Supriseber on ${frame.body}");
            });
        client.send(
            destination: "/app/chat",
            body: jsonEncode({
              "content": "Hello",
              "senderId": idUser,
              "recipientId": "660c33fdd2bf3d74d2c3b304",
              "timestamp": DateTime.now().millisecondsSinceEpoch
            }));

        print('onConnect     tHANHHCOONGG');
      },
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(const Duration(milliseconds: 200));
        print('connecting...');
      },
      onWebSocketError: (dynamic error) =>
          print("LoiKaiWkAIII${error.toString()}"),
    ));
    client.activate();
    BlocProvider.of<GetAllRoomCubit>(context).getAllRoomsUser();
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(child: Scaffold(body: SafeArea(child:
        BlocBuilder<GetAllRoomCubit, GetAllRoomState>(
            builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                                print(
                                    "Entry ${entry.value.userRecipient.sex}");
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
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouterName.chattingWithScreen);
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.sp,
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
                                                        width: 65.sp,
                                                        height: 65.sp,
                                                        fit: BoxFit.cover)
                                                    : entry.value.userRecipient.avatar == "" &&
                                                            entry
                                                                    .value
                                                                    .userRecipient
                                                                    .sex ==
                                                                false
                                                        ? ImageAssets.pngAsset(
                                                            Png.imgUserGirl,
                                                            width: 65.sp,
                                                            height: 65.sp,
                                                            fit: BoxFit.cover)
                                                        : ImageAssets.networkImage(
                                                            url: entry
                                                                .value
                                                                .userRecipient
                                                                .avatar,
                                                            width: 65.sp,
                                                            height: 65.sp,
                                                            fit: BoxFit.cover),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    entry.value.userRecipient
                                                        .name,
                                                    style: text16.black.medium,
                                                  ),
                                                  SizedBox(
                                                    height: 3.sp,
                                                  ),
                                                  SizedBox(
                                                    height: 20.sp,
                                                    width: width * 0.55,
                                                    child: Text(
                                                      entry.value.lastMessage
                                                          .content,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: text16
                                                          .textColor.regular,
                                                    ),
                                                  )
                                                ],
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
