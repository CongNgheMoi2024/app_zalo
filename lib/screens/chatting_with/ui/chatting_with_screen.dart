import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_of_chatting.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ChattingWithScreen extends StatefulWidget {
  const ChattingWithScreen({super.key});

  @override
  State<ChattingWithScreen> createState() => _ChattingWithScreenState();
}

class _ChattingWithScreenState extends State<ChattingWithScreen> {
  String idUser = HiveStorage().idUser;
  String accessToken = HiveStorage().token;
  bool showOptions = false;
  void toggleOptions() => setState(() {
        showOptions = !showOptions;
      });
  void getImage() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 5, // chọn tối đa 5 item
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                HeaderOfChatting(),
                SingleChildScrollView(
                  child: Center(
                    child: Text('Chatting With Screen'),
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
                        height: 200.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Pressed pick image--------------------');
                                getImage();
                              },
                              child: const Icon(
                                Icons.image,
                                size: 100,
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
