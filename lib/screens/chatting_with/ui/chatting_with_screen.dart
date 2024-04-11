import 'dart:convert';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/models/chat/infor_user_chat.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_state.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:app_zalo/utils/send_file.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_of_chatting.dart';
import 'package:app_zalo/widget/media_options_box/media_options_box.dart';
import 'package:app_zalo/widget/message/reciver_mess_item.dart';
import 'package:app_zalo/widget/message/sender_mess_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// ignore: must_be_immutable
class ChattingWithScreen extends StatefulWidget {
  InforUserChat inforUserChat;
  ChattingWithScreen({super.key, required this.inforUserChat});

  @override
  State<ChattingWithScreen> createState() => _ChattingWithScreenState();
}

class _ChattingWithScreenState extends State<ChattingWithScreen> {
  String idUser = HiveStorage().idUser;
  bool showOptions = false;
  FocusNode focusTextField = FocusNode();
  TextEditingController controllerInputMessage = TextEditingController();
  final SendFile _sendFile = SendFile();
  List<dynamic> listMessage = [];

  late StompClient client;

  void toggleOptions() => setState(() {
        showOptions = !showOptions;
      });
  @override
  void initState() {
    super.initState();
    focusTextField.addListener(() {
      if (focusTextField.hasFocus) {
        setState(() {
          showOptions = false;
        });
      }
    });
    client = StompClient(
        config: StompConfig.sockJS(
      url: '${Env.url}/ws',
      onConnect: (StompFrame frame) {
        client.subscribe(
            destination: "/user/$idUser/queue/messages",
            callback: (StompFrame frame) {
              setState(() {
                Map<String, dynamic> data = jsonDecode(frame.body ?? "");
                listMessage.add(MessageOfList(
                    idMessage: data["id"],
                    idChat: data["chatId"],
                    idSender: data["senderId"],
                    idReceiver: data["recipientId"],
                    timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
                    content: data["content"],
                    type: data["type"] ?? "TEXT"));
              });
              print("Supriseber on ${frame.body}");
            });
        print('onConnect     tHANHHCOONGG');
      },
      beforeConnect: () async {
        await Future.delayed(const Duration(milliseconds: 200));
      },
      onWebSocketError: (dynamic error) =>
          // ignore: avoid_print
          print("LoiKaiWkAIII${error.toString()}"),
    ));
    client.activate();
    BlocProvider.of<GetAllMessageCubit>(context)
        .GetAllMessageenticate(idUser, widget.inforUserChat.idUserRecipient);
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }

  int? prevIndex;
  bool isConsecutive = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
      child: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                HeaderOfChatting(
                  nameReceiver: widget.inforUserChat.name,
                  timeActive: widget.inforUserChat.timeActive,
                  urlAvatar: widget.inforUserChat.avatar,
                  sex: widget.inforUserChat.sex,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      reverse: true,
                      child:
                          BlocBuilder<GetAllMessageCubit, GetAllMessageState>(
                              builder: (context, state) {
                        if (state is LoadingGetAllMessageState) {
                          return SizedBox(
                            height: height - 200.sp,
                            width: width,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is GetAllMessageSuccessState) {
                          listMessage = state.data;
                          return Wrap(
                            children: listMessage.asMap().entries.map((entry) {
                              final index = entry.key;
                              final e = entry.value;
                              if (e.idSender == idUser) {
                                return SenderMessItem(
                                  content: e.content,
                                  time: e.timestamp,
                                  type: e.type,
                                  idMessage: e.idMessage,
                                  idReceiver:
                                      widget.inforUserChat.idUserRecipient,
                                  status: e.status,
                                  onDelete: () async {
                                    try {
                                      String accToken = HiveStorage().token;
                                      Dio dio = Dio();
                                      String apiUrl =
                                          "${Env.url}/api/v1/delete-messages/${e.idMessage}";

                                      Response response = await dio.put(apiUrl,
                                          options: Options(headers: {
                                            "Content-Type": "application/json",
                                            "Authorization": "Bearer $accToken",
                                          }));
                                      if (response.statusCode == 200) {
                                        setState(() {
                                          listMessage.removeAt(index);
                                        });
                                        print("Xoa thanh cong");
                                      } else {}
                                    } catch (e) {}
                                  },
                                  onRecall: () {
                                    client.send(
                                      destination: "/app/delete",
                                      body: jsonEncode({
                                        "id": e.idMessage,
                                      }),
                                    );
                                    BlocProvider.of<GetAllMessageCubit>(context)
                                        .GetAllMessageenticate(
                                            idUser,
                                            widget
                                                .inforUserChat.idUserRecipient);
                                    // setState(() {});
                                  },
                                );
                              } else {
                                isConsecutive =
                                    prevIndex != null && prevIndex == index - 1;
                                prevIndex = index;
                                return ReciverMessItem(
                                  avatarReceiver: widget.inforUserChat.avatar,
                                  message: e.content,
                                  time: e.timestamp,
                                  sex: widget.inforUserChat.sex,
                                  showAvatar: isConsecutive,
                                  type: e.type,
                                  idMessage: e.idMessage,
                                  idReceiver:
                                      widget.inforUserChat.idUserRecipient,
                                  onDelete: () async {
                                    try {
                                      String accToken = HiveStorage().token;
                                      Dio dio = Dio();
                                      String apiUrl =
                                          "${Env.url}/api/v1/delete-messages/${e.idMessage}";

                                      Response response = await dio.put(apiUrl,
                                          options: Options(headers: {
                                            "Content-Type": "application/json",
                                            "Authorization": "Bearer $accToken",
                                          }));
                                      if (response.statusCode == 200) {
                                        setState(() {
                                          listMessage.removeAt(index);
                                        });
                                      } else {}
                                    } catch (e) {}
                                  },
                                );
                              }
                            }).toList(),
                          );
                        } else {
                          return SizedBox(
                            height: height - 200.sp,
                            width: width,
                            child: const Center(
                              child: Text("Bạn chưa nhắn tin nào"),
                            ),
                          );
                        }
                      })),
                ),
              ],
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              height: showOptions
                  ? 255.sp + MediaQuery.of(context).viewInsets.bottom
                  : 50.sp + MediaQuery.of(context).viewInsets.bottom,
              color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.sp,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.sp,
                              right: 10.sp,
                              top: 11.sp,
                              bottom: 11.sp),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.sp,
                              right: 5.sp,
                            ),
                            child: TextField(
                              focusNode: focusTextField,
                              controller: controllerInputMessage,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.sp, horizontal: 18.sp),
                                hintText: 'Nhập tin nhắn...',
                                hintStyle: text18.regular.primary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.sp),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.sp,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.sp),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        MediaQuery.of(context).viewInsets.bottom > 10
                            ? InkWell(
                                onTap: () {
                                  String message = controllerInputMessage.text;
                                  if (message.isNotEmpty) {
                                    client.send(
                                      destination: "/app/chat",
                                      body: jsonEncode({
                                        "content": message,
                                        "senderId": idUser,
                                        "recipientId": widget
                                            .inforUserChat.idUserRecipient,
                                        "timestamp": DateTime.now()
                                            .millisecondsSinceEpoch
                                      }),
                                    );

                                    controllerInputMessage.clear();
                                    setState(() {
                                      listMessage.add(MessageOfList(
                                          idMessage: "",
                                          idChat: "",
                                          idSender: idUser,
                                          idReceiver: widget
                                              .inforUserChat.idUserRecipient,
                                          timestamp: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          content: message,
                                          type: ""));
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.sp,
                                      right: 15.sp,
                                      top: 10.sp,
                                      bottom: 10.sp),
                                  child: Icon(
                                    Icons.send,
                                    color: primaryColor,
                                    size: 30.sp,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 10.sp,
                                    right: 15.sp,
                                    top: 10.sp,
                                    bottom: 10.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    if (showOptions == false) {
                                      focusTextField.unfocus();
                                    }
                                    setState(() {
                                      toggleOptions();
                                    });
                                  },
                                  child: ImageAssets.pngAsset(
                                    Png.iconMore,
                                    width: 30.sp,
                                    height: 30.sp,
                                  ),
                                )),
                      ],
                    ),
                  ),
                  MediaOptions(
                    visible: showOptions,
                    onFileSelected: (files) async {
                      List<dynamic> data = await _sendFile.sendFile(
                          idUser, widget.inforUserChat.idUserRecipient, files);
                      if (data.isEmpty) {
                        const AlertDialog(
                          title: Text("Thông báo"),
                          content: Text("Đã xảy ra lỗi!"),
                        );
                      } else {
                        for (var element in data) {
                          setState(() {
                            listMessage.add(MessageOfList(
                                idMessage: "",
                                idChat: "",
                                idSender: idUser,
                                idReceiver:
                                    widget.inforUserChat.idUserRecipient,
                                timestamp: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                content: element["content"].toString(),
                                type: element["type"].toString()));
                          });
                        }
                      }
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
