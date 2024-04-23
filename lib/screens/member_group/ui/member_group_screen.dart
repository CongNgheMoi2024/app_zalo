import 'dart:convert';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_state.dart';
import 'package:app_zalo/screens/member_group/bloc/manage_member.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// ignore: must_be_immutable
class MemberGroupScreen extends StatefulWidget {
  String? idGroup;

  MemberGroupScreen({super.key, required this.idGroup});
  @override
  State<MemberGroupScreen> createState() => _MemberGroupScreenState();
}

class _MemberGroupScreenState extends State<MemberGroupScreen> {
  late StompClient client;
  String? nameYour;
  @override
  void initState() {
    super.initState();
    client = StompClient(
        config: StompConfig.sockJS(
            url: '${Env.url}/ws',
            onConnect: (StompFrame frame) {
              client.subscribe(
                  destination: "/user/${widget.idGroup}/queue/messages",
                  callback: (StompFrame frame) {
                    print("Subscribe chat nhóm  ${frame.body}");
                  });
            }));

    client.activate();
    context.read<GetMembersCubit>().getMembers(widget.idGroup!);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Member user;
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      HeaderTrans(
        title: "Thành viên",
      ),
      BlocBuilder<GetMembersCubit, GetMembersState>(builder: (context, state) {
        if (state is LoadingGetMembersState) {
          return SizedBox(
            height: height - 200.sp,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SuccessGetMembersState) {
          user = state.data
              .firstWhere((element) => element.id == HiveStorage().idUser);
          List<Member> members = state.data;

          return Wrap(
              children: members.map((entry) {
            entry.id == user.id ? nameYour = entry.name : nameYour = "";
            return Padding(
              padding: EdgeInsets.all(5.sp),
              child: ListTile(
                onTap: () {
                  _showActionsList(context, user.role, entry, (bool isSuccess) {
                    isSuccess
                        ? context
                            .read<GetMembersCubit>()
                            .getMembers(widget.idGroup!)
                        : AlertDialog(
                            title: const Text("Lỗi"),
                            content: const Text("Thao tác không thành công"),
                            actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                )
                              ]);
                  });
                },
                title: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Stack(children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.sp),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.sp),
                            child: entry.avatar != ""
                                ? ImageAssets.networkImage(
                                    url: entry.avatar,
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  )
                                : ImageAssets.pngAsset(
                                    Png.imgUserBoy,
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        if (entry.role != RoleGroup.member)
                          Positioned(
                            bottom: 0.sp,
                            right: 0.sp,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: Colors.grey),
                              margin: EdgeInsets.only(left: 10.sp),
                              child: Icon(
                                Icons.key,
                                size: 20.sp,
                                color: entry.role == RoleGroup.admin
                                    ? keyGoldColor
                                    : keySilverColor,
                              ),
                            ),
                          ),
                      ]),
                      Container(
                        margin: EdgeInsets.only(left: 20.sp),
                        child: Text(
                          entry.id == user.id ? "Bạn" : entry.name,
                          style: text15.primary.regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList());
        }
        return Column(
          children: [
            SizedBox(
              height: 200.sp,
              width: width,
              child: Center(
                child: Text(
                  "Lỗi khi tải dữ liệu",
                  style: text16.error,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  context.read<GetMembersCubit>().getMembers(widget.idGroup!);
                },
                child: Container(
                  height: 50.sp,
                  width: 100.sp,
                  color: grey03,
                  child: const Center(
                    child: Text("Thử lại"),
                  ),
                ))
          ],
        );
      }),
    ])));
  }

  void _showActionsList(BuildContext context, RoleGroup userRole, Member member,
      Function(bool) finishAction) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.sp),
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.sp),
                    child: member.avatar != ""
                        ? ImageAssets.networkImage(
                            url: member.avatar,
                            width: 50.sp,
                            height: 50.sp,
                            fit: BoxFit.cover,
                          )
                        : ImageAssets.pngAsset(
                            Png.imgUserBoy,
                            width: 50.sp,
                            height: 50.sp,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.sp),
                  child: Text(
                    member.name,
                    style: text15.primary.regular,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Xem thông tin"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Gọi điện"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Nhắn tin"),
            onTap: () {},
          ),
          if (userRole == RoleGroup.admin && member.role != RoleGroup.admin)
            ListTile(
              title: const Text("Bổ nhiệm làm trưởng nhóm"),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Xác nhận"),
                    content: const Text(
                        "Bạn có chắc chắn muốn bổ nhiệm người này làm trưởng nhóm không?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () async {
                          finishAction(
                              await transferAdmin(widget.idGroup!, member.id));
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text("Đồng ý"),
                      )
                    ],
                  ),
                );
              },
            ),
          if (userRole == RoleGroup.admin && member.role == RoleGroup.member)
            ListTile(
              title: const Text("Bổ nhiệm  làm phó nhóm"),
              onTap: () async {
                finishAction(await grantSubAdmin(widget.idGroup!, member.id));
                Navigator.pop(context);
              },
            ),
          if (userRole == RoleGroup.admin && member.role == RoleGroup.subadmin)
            ListTile(
              title: const Text("Xoá vai trò phó nhóm"),
              onTap: () async {
                finishAction(await revokeSubAdmin(widget.idGroup!, member.id));
                Navigator.pop(context);
              },
            ),
          if (userRole.index < member.role.index)
            ListTile(
                title: const Text("Xóa khỏi nhóm"),
                onTap: () {
                  removeUser(member.id, widget.idGroup!).then((value) {
                    if (value == true) {
                      client.send(
                        destination: "/app/group/remove-member",
                        body: jsonEncode({
                          "chatId": widget.idGroup!,
                          "senderId": HiveStorage().idUser,
                          "recipientId": member.id,
                          "content":
                              "$nameYour đã xóa ${member.name} khỏi nhóm",
                          "timestamp":
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        }),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Lỗi"),
                                content: const Text(
                                    "Nếu có ít hơn 3 người thì không thể xóa thành viên khỏi nhóm"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ));
                    }
                  });
                })
        ],
      )),
    );
  }
}

Future<bool> removeUser(String idUser, String idRoom) async {
  String accessToken = HiveStorage().token;
  try {
    Dio dio = Dio();
    String apiUrl = "${Env.url}/api/v1/rooms/$idRoom/remove-member/$idUser";

    Response response = await dio.put(
      apiUrl,
      options: Options(headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("LOOOOOOOOOOOOOOOOOOOOIIIIIII");
      return false;
    }
  } catch (e) {
    print("LOO ${e.toString()}");
    return false;
  }
}
