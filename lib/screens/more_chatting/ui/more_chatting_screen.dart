import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/models/chat/infor_user_chat.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/more_chatting/bloc/delete_room_cubit.dart';
import 'package:app_zalo/screens/more_chatting/bloc/delete_room_state.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreChattingScreen extends StatefulWidget {
  InforUserChat? inforUserChat;

  MoreChattingScreen({super.key, this.inforUserChat});

  @override
  State<MoreChattingScreen> createState() => _MoreChattingScreenState();
}

class _MoreChattingScreenState extends State<MoreChattingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTrans(
              title: "Tùy chọn",
            ),
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              width: width,
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: ImageAssets.pngAsset(
                        Png.imgAnhBia,
                        width: 100.sp,
                        height: 100.sp,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 3.sp,
                      bottom: 3.sp,
                      child: Container(
                          height: 25.sp,
                          width: 25.sp,
                          decoration: BoxDecoration(
                              color: greyIcTop.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(80.sp)),
                          child: Icon(
                            Icons.camera_enhance_outlined,
                            size: 17.sp,
                            color: whiteColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.065,
                    child: Center(
                      child: Text(
                        "Báo cáo Công nghê",
                        style: text18.primary.medium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Icon(Icons.edit_outlined, size: 20.sp, color: primaryColor)
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.sp),
                padding: EdgeInsets.symmetric(
                  vertical: 20.sp,
                  horizontal: 10.sp,
                ),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.find_in_page_outlined, size: 30.sp),
                        Container(
                            margin: EdgeInsets.only(top: 5.sp),
                            width: width * 0.2,
                            child: Text("Tìm kiếm tin nhắn",
                                textAlign: TextAlign.center,
                                style: text16.primary.regular))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.add_reaction_outlined, size: 30.sp),
                        Container(
                            margin: EdgeInsets.only(top: 5.sp),
                            width: width * 0.2,
                            child: Text("Thêm thành viên",
                                textAlign: TextAlign.center,
                                style: text16.primary.regular))
                      ],
                    ),
                  ],
                )),
            BlocBuilder<DeleteRoomCubit, DeleteRoomState>(
                builder: (context, stateFastContact) {
              if (stateFastContact is LoadingDeleteRoomState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (stateFastContact is DeleteRoomSuccessState) {
                Future.delayed(Duration.zero, () {
                  Navigator.pushReplacementNamed(
                      context, RouterName.dashboardScreen);
                });
                return Center();
              } else {
                return InkWell(
                  onTap: () {
                    context
                        .read<DeleteRoomCubit>()
                        .DeleteRoomenticate(widget.inforUserChat!.idGroup!);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.sp),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.sp,
                        ),
                        child: Icon(
                          Icons.delete_sweep_outlined,
                          size: 30.sp,
                          color: errorColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            padding: EdgeInsets.symmetric(
                              vertical: 15.sp,
                              horizontal: 10.sp,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: primaryColor.withOpacity(0.2),
                                    width: 1.sp),
                                bottom: BorderSide(
                                    color: primaryColor.withOpacity(0.2),
                                    width: 1.sp),
                              ),
                            ),
                            child:
                                Text("Xóa nhóm", style: text17.error.regular)),
                      ),
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
