import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/forward/bloc/forward_message_cubit.dart';
import 'package:app_zalo/screens/forward/ui/forward_message_screen.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenderMessItem extends StatefulWidget {
  String? content;
  String? time;
  String? type;
  String? idMessage;
  String? idReceiver;

  SenderMessItem({super.key, required content, required time, required type, required idMessage, required String idReceiver});

  @override
  State<SenderMessItem> createState() => _SenderMessItemState();
}

class _SenderMessItemState extends State<SenderMessItem> {
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    child: Text(widget.content!)),
              ],
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 55.sp,
                  right: 5.sp,
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
                                    idMessage: widget.idMessage!,
                                    idReceiver: widget.idReceiver!,
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
                )
              ]),
            )
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onLongPress: () {
                  _showMessageDetailsModal(context);
                },
                onTap: () {
                  setState(() {
                    visibleDetail = !visibleDetail;
                  });
                },
                child: Container(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: width * 0.65,
                    ),
                    margin: EdgeInsets.only(right: 15.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                        bottomLeft: Radius.circular(20.sp),
                      ),
                    ),
                    child: widget.type == "IMAGE"
                        ? Image.network(
                            widget.content!,
                            height: 150.sp,
                            width: 250.sp,
                            fit: BoxFit.cover,
                          )
                        : Text(
                            widget.content!,
                            style: text16.primary.regular,
                          )),
              ),
            ],
          ),
          visibleDetail
              ? Container(
                  margin: EdgeInsets.only(
                    right: 20.sp,
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
}
