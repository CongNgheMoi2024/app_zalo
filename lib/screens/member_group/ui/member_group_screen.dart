import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_state.dart';
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
      BlocBuilder<GetMembersCubit, GetMembersState>(
          builder: (context, state) {
        if (state is LoadingGetMembersState) {
          return SizedBox(
            height: height - 200.sp,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SuccessGetMembersState) {
          user = state.data.firstWhere((element) => element.id == HiveStorage().idUser);
          return Wrap(
              children: state.data.map((entry) {
            return Padding(
              padding: EdgeInsets.all(15.sp),
              child: GestureDetector(
                onTap: () {
                  _showActionsList(context,user.role,entry);},
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
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
                      Container(
                        margin: EdgeInsets.only(left: 20.sp),
                        child: Text(
                          entry.name,
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
        return Container();
      }),
    ])));
  }
  
  void _showActionsList(BuildContext context,RoleGroup userRole,Member member) {
    showModalBottomSheet(context: context, builder:(context)=> Container(
      child: Column(children: [
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
          onTap: (){},
        ),
        ListTile(
          title: const Text("Gọi điện"),
          onTap: (){},
        ),
        ListTile(
          title: const Text("Nhắn tin"),
          onTap: (){},
        ),

        if(userRole == RoleGroup.admin && member.role != RoleGroup.admin) ListTile(
          title: const Text("Bổ nhiệm làm trưởng nhóm"),
          onTap: (){},
        ),
        if(userRole == RoleGroup.admin &&  member.role == RoleGroup.member) ListTile(
          title: const Text("Bổ nhiệm  làm phó nhóm"),
          onTap: (){},
        ),
                if(userRole == RoleGroup.admin &&  member.role == RoleGroup.subadmin) ListTile(
          title: const Text("Xoá vai trò phó nhóm"),
          onTap: (){},
        ),        if(userRole.index <  member.role.index) ListTile(
          title: const Text("Xóa khỏi nhóm"),
          onTap: (){})
      
      ],)
        
        ),
    
    );
    
}
}