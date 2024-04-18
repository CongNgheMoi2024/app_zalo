// ignore_for_file: use_build_context_synchronously

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_state.dart';
import 'package:app_zalo/screens/member_group/bloc/manage_member.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MemberGroupScreen extends StatefulWidget {
  List<String>? members;
  String? idGroup;
  MemberGroupScreen({super.key, required this.idGroup});
  @override
  State<MemberGroupScreen> createState() => _MemberGroupScreenState();
}

class _MemberGroupScreenState extends State<MemberGroupScreen> {
  @override
  void initState() {
    super.initState();
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
                            bottom: 0.sp, // Đặt icon ở góc dưới
                            right: 0.sp, // Đặt icon ở bên phải
                            child: Container(
                              width: 20.sp,
                              height: 20.sp,
                              margin: EdgeInsets.only(
                                  left: 10.sp), // Khoảng cách bên trái
                              child: Icon(Icons.key,size:20.sp,color: entry.role == RoleGroup.admin? keyGoldColor : keySilverColor,) ,
                            ),
                          ),
                      ]),
                      Container(
                        margin: EdgeInsets.only(left: 20.sp),
                        child: Text(entry.id == user.id ? "Bạn" : entry.name,
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
                  context: context
                  ,
                  builder:(context)=> AlertDialog(
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
                          finishAction(await transferAdmin(widget.idGroup!, member.id));
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
            ListTile(title: const Text("Xóa khỏi nhóm"), onTap: () {})
        ],
      )),
    );
  }
}
