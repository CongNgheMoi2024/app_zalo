import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_state.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_of_chatting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_zalo/widget/message/reciver_mess_item.dart';
import 'package:app_zalo/widget/message/sender_mess_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class InforUserChat {
  String idUserRecipient;
  String name;
  String avatar;
  String timeActive;
  bool sex;
  InforUserChat(
      {required this.idUserRecipient,
      required this.name,
      required this.avatar,
      required this.timeActive,
      required this.sex});
}

// ignore: must_be_immutable
class ChattingWithScreen extends StatefulWidget {
  InforUserChat inforUserChat;
  ChattingWithScreen({super.key, required this.inforUserChat});

  @override
  State<ChattingWithScreen> createState() => _ChattingWithScreenState();
}

class _ChattingWithScreenState extends State<ChattingWithScreen> {
  String idUser = HiveStorage().idUser;
  String accessToken = HiveStorage().token;
  bool showOptions = false;
  final int sizeMax = 100 * 1024 * 1024;
  void toggleOptions() => setState(() {
        showOptions = !showOptions;
      });
  Future<List<AssetEntity>> getImagesAndVideos() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
            maxAssets: 10,
            requestType: RequestType.common,
            selectPredicate: (context, asset, isSelected) =>
                isAssetSizeAllowed(context, asset)));
    if (result == null) {
      return [];
    } else {
      return result;
    }}
    TextEditingController controllerInputMessage = TextEditingController();

    List<dynamic> listMessage = [];

    late StompClient client;

    Future<List<AssetEntity>> getAudios() async {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
              maxAssets: 10,
              requestType: RequestType.audio,
              selectPredicate: (context, asset, isSelected) =>
                  isAssetSizeAllowed(context, asset)));
      if (result == null) {
        return [];
      } else {
        return result;
      }
    }

    Future<List<File>> getFiles(BuildContext context) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        List<File> files = [];
        for (String? path in result.paths) {
          if (path != null) {
            File file = File(path);
            if (await file.length() < sizeMax) {
              files.add(file);
            } else {
              showAlertDialog();
              return [];
            }
          }
        }
        return files;
      } else {
        return [];
      }
    }

    void showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text("Kích thước tệp vượt quá 100MB."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    bool isAssetSizeAllowed(BuildContext context, AssetEntity asset) {
      Size assetSize = asset.size;
      int assetSizeByte = (assetSize.width * assetSize.height).toInt();
      if (assetSizeByte > sizeMax) {
        showAlertDialog();
        return false;
      }
      return true;
    }
// config stompclient with sockjs
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
                print("Message  body= ${frame.body}");

              });
          // client.send(
          //     destination: "/app/chat",
          //     body: jsonEncode({
          //       "content": "Hello",
          //       "senderId": idUser,
          //       "recipientId": "660c33fdd2bf3d74d2c3b304",
          //       "timestamp": DateTime.now().millisecondsSinceEpoch
          //     }));

          print('onConnect     tHANHHCOONGG');
        },

        beforeConnect: () async {
          await Future.delayed(const Duration(milliseconds: 200));
        },
        onWebSocketError: (dynamic error) =>
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
                    child: SingleChildScrollView(child:
                        BlocBuilder<GetAllMessageCubit, GetAllMessageState>(
                            builder: (context, state) {
                      if (state is LoadingGetAllMessageState) {
                        return SizedBox(
                          height: height - 200.sp,
                          width: width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is GetAllMessageSuccessState) {
                        listMessage = state.data;
                        return Wrap(
                          children: listMessage.map((e) {
                            if (e.idSender == idUser) {
                              return SenderMessItem(
                                content: e.content,
                                time: e.timestamp,
                              );
                            } else {
                              return ReciverMessItem(
                                  avatarReceiver: widget.inforUserChat.avatar,
                                  message: e.content,
                                  time: e.timestamp,
                                  sex: widget.inforUserChat.sex);
                            }
                          }).toList(),
                        );
                      } else {
                        return SizedBox(
                          height: height - 200.sp,
                          width: width,
                          child: Center(
                            child: Text("Bạn chưa nhắn tin nào"),
                          ),
                        );
                      }
                    })),
                  ),
                ],
              ),
              bottomNavigationBar: AnimatedContainer(
                duration: Duration(milliseconds: 0),
                height: showOptions
                    ? 255.sp + MediaQuery.of(context).viewInsets.bottom
                    : 50.sp + MediaQuery.of(context).viewInsets.bottom,
                color: whiteColor,
                // duration: const Duration(milliseconds: 0),
                // height: showOptions
                //     ? 250.sp + MediaQuery.of(context).viewInsets.bottom
                //     : 50.sp + MediaQuery.of(context).viewInsets.bottom,
                // color: Colors.transparent,

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
                            child: ImageAssets.pngAsset(
                              Png.iconSticker,
                              height: 28.sp,
                              color: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 5.sp,
                                right: 5.sp,
                              ),
                              child: TextField(
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
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: 10.sp, right: 15.sp, top: 10.sp, bottom: 10.sp),
                          //   child: Icon(
                          //     Icons.send,
                          //     color: primaryColor,
                          //     size: 30.sp,
                          //   ),
                          // ),
                          MediaQuery.of(context).viewInsets.bottom > 10
                              ? InkWell(
                                  onTap: () {
                                    String message = controllerInputMessage
                                        .text; // Assuming controllerInputMessage is a TextEditingController for your TextField
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
                                    onTap: () => setState(() {
                                      toggleOptions();
                                    }),
                                    child: ImageAssets.pngAsset(
                                      Png.iconMore,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                                  )),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: showOptions,
                        child: Container(
                          margin: EdgeInsets.only(top: 5.sp),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 1,
                                      color: grey03.withOpacity(0.5)))),
                          height: 200.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getImagesAndVideos()
                                      .then((List<AssetEntity> assets) {
                                    assets.forEach((element) {
                                      print(
                                          "---------${element.title}--------type ---${element.type}");
                                    });
                                  }).catchError((error) {
                                    // Xử lý lỗi nếu có
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.sp),
                                  margin: EdgeInsets.all(5.sp),
                                  child: Column(
                                    children: [
                                      ImageAssets.pngAsset(Png.iconPhoto,
                                          width: 60.sp, height: 60.sp),
                                      const Text('Hình ảnh'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  getAudios()
                                      .then((assets) =>
                                          assets.forEach((element) {
                                            print("---------${element.title}");
                                          }))
                                      .catchError((error) {
                                    print(
                                        '--------Lỗi khi lấy audio----------');
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.sp),
                                  margin: EdgeInsets.all(5.sp),
                                  child: Column(
                                    children: [
                                      ImageAssets.pngAsset(Png.iconAudio,
                                          width: 60.sp, height: 60.sp),
                                      const Text('Âm thanh'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  getFiles(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.sp),
                                  margin: EdgeInsets.all(5.sp),
                                  child: Column(
                                    children: [
                                      ImageAssets.pngAsset(Png.iconDocument,
                                          width: 60.sp, height: 60.sp),
                                      const Text('Tài liệu'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ),
      );
    }
  }
