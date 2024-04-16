import 'dart:convert';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/models/chat/infor_user_chat.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_state.dart';
import 'package:app_zalo/screens/chatting_with/bloc/send_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/bloc/send_message_state.dart';
import 'package:app_zalo/screens/more_chatting/bloc/delete_room_cubit.dart';
import 'package:app_zalo/screens/more_chatting/ui/more_chatting_screen.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:app_zalo/utils/send_file.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_of_chatting.dart';
import 'package:app_zalo/widget/media_options_box/media_options_box.dart';
import 'package:app_zalo/widget/message/reciver_mess_item.dart';
import 'package:app_zalo/widget/message/sender_mess_item.dart';
import 'package:app_zalo/widget/show_message_by_type/show_reply.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  FocusNode focusMediaOptionsBox = FocusNode();
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
    client = StompClient(
        config: StompConfig.sockJS(
      url: '${Env.url}/ws',
      onConnect: (StompFrame frame) {
        widget.inforUserChat.isGroup == true
            ? client.subscribe(
                destination:
                    "/user/${widget.inforUserChat.idGroup}/queue/messages",
                callback: (StompFrame frame) {
                  setState(() {
                    Map<String, dynamic> data = jsonDecode(frame.body ?? "");
                    listMessage.add(MessageOfList(
                      idMessage: data["id"],
                      idChat: data["chatId"],
                      idSender: data["senderId"],
                      idReceiver: data["recipientId"] ?? "",
                      timestamp: DateFormat('HH:mm dd/MM').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              data["timestamp"])),
                      content: data["content"],
                      type: data["type"] ?? "TEXT",
                      replyTo: data["replyTo"] ?? "",
                      fileName: data["fileName"] ?? "",
                    ));
                  });
                  print("Supriseber on ${frame.body}");
                })
            : client.subscribe(
                destination: "/user/$idUser/queue/messages",
                callback: (StompFrame frame) {
                  setState(() {
                    Map<String, dynamic> data = jsonDecode(frame.body ?? "");
                    listMessage.add(MessageOfList(
                      idMessage: data["id"],
                      idChat: data["chatId"],
                      idSender: data["senderId"],
                      idReceiver: data["recipientId"] ?? "",
                      timestamp: DateFormat('HH:mm dd/MM').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              data["timestamp"])),
                      content: data["content"],
                      type: data["type"] ?? "TEXT",
                      replyTo: data["replyTo"] ?? "",
                      fileName: data["fileName"] ?? "",
                    ));
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
          print("LoiKaiWkAIIIIIIIIIIII${error.toString()}"),
    ));
    client.activate();
    BlocProvider.of<GetAllMessageCubit>(context).GetAllMessageenticate(
        idUser,
        widget.inforUserChat.idUserRecipient,
        widget.inforUserChat.isGroup!,
        widget.inforUserChat.idGroup!);
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
    focusTextField.dispose();
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
                  nameReceiver: widget.inforUserChat.isGroup == true
                      ? widget.inforUserChat.nameGroup
                      : widget.inforUserChat.name,
                  timeActive: widget.inforUserChat.timeActive,
                  urlAvatar: widget.inforUserChat.avatar,
                  sex: widget.inforUserChat.sex,
                  actionMenuMore: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<DeleteRoomCubit>(
                                create: (BuildContext context) =>
                                    DeleteRoomCubit(),
                                child: MoreChattingScreen(
                                  idRoom: widget.inforUserChat.idGroup,
                                ))));
                  },
                  isGroup: widget.inforUserChat.isGroup,
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
                                  fileName: e.fileName,
                                  infoMessReply: e.replyTo == ""
                                      ? null
                                      : listMessage.firstWhere(
                                        (element) =>element is MessageOfList && element.idMessage ==e.replyTo,

                                        ),
                                  nameUserReply:"line 194 chatting with screen", //LỖI VỚI CHAT GROUP
                                  idMessage: e.idMessage,
                                  idReceiver: widget.inforUserChat.idUserRecipient,
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
                                                .inforUserChat.idUserRecipient,
                                            widget.inforUserChat.isGroup!,
                                            widget.inforUserChat.idGroup!);
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
                                  fileName: e.fileName,
                                  replyTo: e.replyTo,
                                  infoMessReply: e.replyTo == ""
                                      ? null
                                      : listMessage.firstWhere(
                                        (element) =>element is MessageOfList && element.idMessage ==e.replyTo,

                                        ),
                                  userNameReply: "Line 253 chatting with screen", //LỖI VỚI CHAT GROUP
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
            bottomNavigationBar:
                BlocBuilder<SendMessageCubit, SendMessageState>(
              builder: (context, state) {
                // ignore: unused_local_variable
                bool isReply = state is ReplySendMessageState;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  height: showOptions && isReply
                      ? 345.sp + MediaQuery.of(context).viewInsets.bottom
                      : showOptions
                          ? 255.sp + MediaQuery.of(context).viewInsets.bottom: isReply?
                          145.sp + MediaQuery.of(context).viewInsets.bottom
                          : 50.sp + MediaQuery.of(context).viewInsets.bottom,
                  color: whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isReply
                          ? Container(
                              margin: EdgeInsets.all(5.sp),
                              padding: EdgeInsets.all(5.sp),
                              color: primaryColor.withOpacity(0.1),
                              height: 80.sp,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: getWidgetByType(state.nameReply!, state.typeMessRep!, state.fileName!, state.contentMessRep!),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<SendMessageCubit>()
                                            .defaultState();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                            )
                          : Container(),
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
                                  autofocus: true,
                                  focusNode: focusTextField,
                                  controller: controllerInputMessage,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.sp, horizontal: 18.sp),
                                    hintText: 'Nhập tin nhắn...',
                                    hintStyle: text18.regular.primary,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 1.sp,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
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
                                      String message =
                                          controllerInputMessage.text;
                                      if (message.isNotEmpty) {
                                        if (isReply) {
                                          client.send(
                                            destination: "/app/chat",
                                            body: jsonEncode({
                                              "content": message,
                                              "senderId": idUser,
                                              "recipientId": widget
                                                  .inforUserChat
                                                  .idUserRecipient,
                                              "timestamp": DateTime.now()
                                                  .millisecondsSinceEpoch,
                                              "replyTo": state.idMessageReply,
                                            }),
                                          );
                                          if (widget.inforUserChat
                                                  .isGroup = // Chỉ cập nhât list message khi chat room là group
                                              true) {
                                            setState(() {
                                              listMessage.add(MessageOfList(
                                                  fileName: "",
                                                  replyTo:
                                                      state.idMessageReply!,
                                                  idMessage: widget
                                                      .inforUserChat.idGroup!, // cũ .inforUserChat.idGroup
                                                  idChat: "",
                                                  idSender: idUser,
                                                  idReceiver: widget
                                                      .inforUserChat
                                                      .idUserRecipient,
                                                  timestamp: DateFormat(
                                                          'yyyy-MM-ddTHH:mm:ss.SSSZ')
                                                      .format(DateTime.now()),
                                                  content: message,
                                                  type: ""));
                                            });
                                          }
                                          context
                                              .read<SendMessageCubit>()
                                              .defaultState();
                                        } else {
                                          client.send(
                                            destination:
                                                // ignore: unrelated_type_equality_checks
                                                widget.inforUserChat.isGroup ==
                                                        true
                                                    ? "/app/chat/group"
                                                    : "/app/chat",
                                            body: jsonEncode({
                                              "chatId":
                                                  widget.inforUserChat.idGroup,
                                              "senderId": idUser,
                                              "recipientId": widget
                                                  .inforUserChat
                                                  .idUserRecipient,
                                              "content": message,
                                              "timestamp": DateFormat(
                                                      'yyyy-MM-ddTHH:mm:ss.SSSZ')
                                                  .format(DateTime.now()),
                                            }),
                                          );
                                          if (widget.inforUserChat
                                                  .isGroup = // Chỉ cập nhât list message khi chat room là group
                                              true) {
                                            setState(() {
                                              listMessage.add(MessageOfList(
                                                  fileName: "",
                                                  replyTo: "",
                                                  idMessage: widget
                                                      .inforUserChat.idGroup!, // cũ .inforUserChat.idGroup
                                                  idChat: "",
                                                  idSender: idUser,
                                                  idReceiver: widget
                                                      .inforUserChat
                                                      .idUserRecipient,
                                                  timestamp: DateFormat(
                                                          'yyyy-MM-ddTHH:mm:ss.SSSZ')
                                                      .format(DateTime.now()),
                                                  content: message,
                                                  type: ""));
                                            });
                                          }
                                        }

                                        controllerInputMessage.clear();
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
                                        color:
                                            isReply ? greenColor : primaryColor,
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
                                        setState(() {
                                          toggleOptions();
                                        });
                                        if (focusMediaOptionsBox.hasFocus ==
                                            false) {
                                          FocusScope.of(context).requestFocus(
                                              focusMediaOptionsBox);
                                        }
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
                      Focus(
                        focusNode: focusMediaOptionsBox,
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            setState(() {
                              showOptions = false;
                            });
                          }
                        },
                        child: MediaOptions(
                          visible: showOptions,
                          onFileSelected: (files) async {
                            List<dynamic> data = await _sendFile.sendFile(
                                idUser,
                                widget.inforUserChat.idUserRecipient,
                                files);
                            if (data.isEmpty) {
                              const AlertDialog(
                                title: Text("Thông báo"),
                                content: Text("Đã xảy ra lỗi!"),
                              );
                            } else {
                              for (var element in data) {
                                setState(() {
                                  listMessage.add(MessageOfList(
                                      replyTo: "",
                                      idMessage: "",
                                      idChat: "",
                                      fileName: element["fileName"],
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
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
