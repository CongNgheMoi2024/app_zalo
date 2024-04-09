import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_of_chatting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ChattingWithScreen extends StatefulWidget {
  const ChattingWithScreen({super.key});

  @override
  State<ChattingWithScreen> createState() => _ChattingWithScreenState();
}

class _ChattingWithScreenState extends State<ChattingWithScreen> {
  List<String> messages = ['Hi', 'Hello'];
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
    }
  }

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

  late StompClient client ;
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
                  print("Subscriber on ${frame.body}");
                });
            client.send(
                destination: "/app/chat",
                body: jsonEncode({
                  "content": "Hellooooooo",
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
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                HeaderOfChatting(),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => Text(messages[index]?? ''),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: Duration(milliseconds: 0),
              height: showOptions
                  ? 250.sp + MediaQuery.of(context).viewInsets.bottom
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
                              left: 15.sp,
                              right: 10.sp,
                              top: 10.sp,
                              bottom: 10.sp),
                          child: ImageAssets.pngAsset(
                            Png.iconSticker,
                            width: 30.sp,
                            height: 30.sp,
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
                        Padding(
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
                                color: primaryColor,
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
                                    width: 1, color: grey03.withOpacity(0.5)))),
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
                                    .then((assets) => assets.forEach((element) {
                                          print("---------${element.title}");
                                        }))
                                    .catchError((error) {
                                  print('--------Lỗi khi lấy audio----------');
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
