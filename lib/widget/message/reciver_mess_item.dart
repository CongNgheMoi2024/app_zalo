import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/forward/bloc/forward_message_cubit.dart';
import 'package:app_zalo/screens/forward/ui/forward_message_screen.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:app_zalo/widget/page_view_image/page_view_image.dart';
import 'package:app_zalo/widget/show_message_by_type/bloc/download_cubit.dart';
import 'package:app_zalo/widget/show_message_by_type/extended_image.dart';
import 'package:app_zalo/widget/show_message_by_type/show_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../screens/chatting_with/bloc/send_message_cubit.dart';
import '../show_message_by_type/show_reply.dart';

// ignore: must_be_immutable
class ReciverMessItem extends StatefulWidget {
  String? avatarReceiver;
  String? message;
  String? time;
  bool? sex;
  bool? showAvatar;
  String? type;
  MessageOfList? infoMessReply;
  String? idMessage;
  String? idReceiver;
  String? fileName;
  String? replyTo;
  String? userMessReply;
  String? userSendMess;
  Function? onDelete;
  String? name;

  ReciverMessItem(
      {super.key,
      this.avatarReceiver,
      this.message,
      this.time,
      this.sex,
      this.showAvatar,
      this.type,
      this.infoMessReply,
      this.idMessage,
      this.idReceiver,
      this.fileName,
      this.userMessReply,
      this.userSendMess,
      this.replyTo,
      this.onDelete,
      this.name});

  @override
  State<ReciverMessItem> createState() => _ReciverMessItemState();
}

class _ReciverMessItemState extends State<ReciverMessItem> {
  bool visibleDetail = false;
  void _showMessageDetailsModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      constraints: BoxConstraints(
        maxHeight: height * 0.8,
        maxWidth: width - 20.sp,
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: width,
                child: Center(
                  child: Text(
                    widget.time!,
                    style: text14.regular
                        .copyWith(color: greyIcBot, fontSize: 14.sp),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.sp,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.sp),
                    child: widget.avatarReceiver != ""
                        ? Image.network(
                            widget.avatarReceiver!,
                            width: 45.sp,
                            height: 45.sp,
                            fit: BoxFit.cover,
                          )
                        : widget.sex!
                            ? ImageAssets.pngAsset(Png.imgUserBoy,
                                width: 45.sp, height: 45.sp, fit: BoxFit.cover)
                            : ImageAssets.pngAsset(Png.imgUserGirl,
                                width: 45.sp, height: 45.sp, fit: BoxFit.cover),
                  ),
                ),
                Container(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: width * 0.65,
                    ),
                    margin: EdgeInsets.only(left: 10.sp),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 17.sp),
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: widget.type == "IMAGE"
                        ? Image.network(
                            widget.message!,
                            fit: BoxFit.cover,
                            height: 150.sp,
                            width: 250.sp,
                          )
                        : widget.type == "VIDEO"
                            ? Text(
                                "VIDEO_MEDIA.mp4",
                                style: text16.primary.regular,
                              )
                            : Text(
                                widget.message!,
                                style: text16.primary.regular,
                              ))
              ],
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 55.sp,
                  top: 5.sp,
                ),
                child: Text(
                  "Đã xem",
                  style: text14.medium.copyWith(
                      color: primaryColor.withOpacity(0.8), fontSize: 13.sp),
                )),
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(
                      color: boxMessShareColor.withOpacity(0.4), width: 1.sp)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {
                    context.read<SendMessageCubit>().replyMessage(
                        widget.userSendMess!,
                        widget.message!,
                        widget.type!,
                        widget.fileName!,
                        widget.idMessage!);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    child: Column(
                      children: [
                        ImageAssets.pngAsset(
                          Png.icReply,
                          width: 40.sp,
                          height: 30.sp,
                        ),
                        SizedBox(height: 5.sp),
                        Text(
                          "Trả lời",
                          style: text14.medium
                              .copyWith(color: greenDC, fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<GetAllRoomCubit>(
                                      create: (BuildContext context) =>
                                          GetAllRoomCubit(),
                                    ),
                                    BlocProvider<ForwardMessageCubit>(
                                      create: (BuildContext context) =>
                                          ForwardMessageCubit(),
                                    ),
                                  ],
                                  child: ForwardMessageScreen(
                                    idMessage: widget.idMessage,
                                    idReceiver: widget.idReceiver,
                                  ))),
                    );
                  },
                  child: Column(
                    children: [
                      ImageAssets.pngAsset(
                        Png.icForward,
                        width: 30.sp,
                        height: 30.sp,
                      ),
                      SizedBox(height: 5.sp),
                      Text(
                        "Chuyển tiếp",
                        style: text14.medium.copyWith(
                            color: lightBlue.withOpacity(0.8), fontSize: 13.sp),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: widget.onDelete != null
                      ? () {
                          widget.onDelete!();
                          Navigator.pop(context);
                        }
                      : () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    child: Column(
                      children: [
                        ImageAssets.pngAsset(
                          Png.icDelete,
                          width: 30.sp,
                          height: 30.sp,
                        ),
                        SizedBox(height: 5.sp),
                        Text(
                          "Xóa",
                          style: text14.medium.copyWith(
                              color: errorColor.withOpacity(0.8),
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ]),
        );
      },
    );
  }

  late VideoPlayerController _videoPalyerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.type == "VIDEO") {
      // ignore: deprecated_member_use
      _videoPalyerController = VideoPlayerController.network(widget.message!);
      _initializeVideoPlayerFuture = _videoPalyerController.initialize();
    }
  }

  @override
  void dispose() {
    if (widget.type == "VIDEO") {
      _videoPalyerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(top: !widget.showAvatar! ? 5.sp : 0, bottom: 2.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          visibleDetail
              ? SizedBox(
                  width: width,
                  child: Center(
                    child: Text(
                      widget.time!,
                      style: text14.regular
                          .copyWith(color: greyIcBot, fontSize: 14.sp),
                    ),
                  ))
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !widget.showAvatar!
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: 10.sp,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.sp),
                        child: widget.avatarReceiver != ""
                            ? Image.network(
                                widget.avatarReceiver!,
                                width: 35.sp,
                                height: 35.sp,
                                fit: BoxFit.cover,
                              )
                            : widget.sex!
                                ? ImageAssets.pngAsset(Png.imgUserBoy,
                                    width: 35.sp,
                                    height: 35.sp,
                                    fit: BoxFit.cover)
                                : ImageAssets.pngAsset(Png.imgUserGirl,
                                    width: 35.sp,
                                    height: 35.sp,
                                    fit: BoxFit.cover),
                      ),
                    )
                  : SizedBox(
                      width: 45.sp,
                      height: 35.sp,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !widget.showAvatar!
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: 10.sp,
                          ),
                          child: Text(
                            widget.name ?? "",
                            style: text14.regular.black,
                          ),
                        )
                      : Container(),
                  InkWell(
                    onLongPress: () {
                      _showMessageDetailsModal(context);
                    },
                    onDoubleTap: _onDoubleTap,
                    onTap: () {
                      setState(() {
                        visibleDetail = !visibleDetail;
                      });
                    },
                    child: BlocProvider(
                      create: (BuildContext context) => DownloadCubit(),
                      child: Container(
                          constraints: BoxConstraints(
                            minWidth: 0,
                            maxWidth: width * 0.6,
                          ),
                          margin: EdgeInsets.only(left: 10.sp),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.sp, horizontal: 15.sp),
                          decoration: BoxDecoration(
                            color:
                                widget.type == "IMAGE" || widget.type == "VIDEO"
                                    ? Colors.transparent
                                    : primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    !widget.showAvatar! ? 20.sp : 5.sp),
                                topRight: Radius.circular(
                                    !widget.showAvatar! ? 20.sp : 5.sp),
                                bottomLeft: Radius.circular(5.sp),
                                bottomRight: Radius.circular(5.sp)),
                          ),
                          child: widget.infoMessReply != null
                              ? Column(
                                  children: [
                                    getWidgetByType(
                                        widget.userMessReply!,
                                        widget.infoMessReply!.type,
                                        widget.infoMessReply!.fileName,
                                        widget.infoMessReply!.content),
                                    Text(
                                      widget.message!,
                                      style: text16.primary.regular,
                                      softWrap: true,
                                    )
                                  ],
                                )
                              : widget.type == "IMAGE"
                                  ? ExtendedImageCustom(url: widget.message!)
                                  : widget.type == "VIDEO"
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (_videoPalyerController
                                                  .value.isPlaying) {
                                                _videoPalyerController.pause();
                                              } else {
                                                _videoPalyerController.play();
                                              }
                                            });
                                          },
                                          child: FutureBuilder(
                                            future:
                                                _initializeVideoPlayerFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return AspectRatio(
                                                  aspectRatio:
                                                      _videoPalyerController
                                                          .value.aspectRatio,
                                                  child: VideoPlayer(
                                                      _videoPalyerController),
                                                );
                                              } else {
                                                return const CircularProgressIndicator();
                                              }
                                            },
                                          ),
                                        )
                                      : widget.type == "FILE"
                                          ? FileView(
                                              url: widget.message!,
                                              fileName: widget.fileName!,
                                            )
                                          : Text(
                                              widget.message!,
                                              style: text16.primary.regular,
                                            )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          visibleDetail
              ? Container(
                  margin: EdgeInsets.only(
                    left: 55.sp,
                    top: 5.sp,
                  ),
                  child: Text(
                    "Đã xem",
                    style: text14.medium.copyWith(
                        color: primaryColor.withOpacity(0.8), fontSize: 13.sp),
                  ))
              : Container(),
        ],
      ),
    );
  }

  void _onDoubleTap() {
    if (widget.type == "IMAGE") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImagePageView(url: widget.message!),
        ),
      );
    }
  }
}
