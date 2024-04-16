import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_state.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberGroupScreen extends StatefulWidget {
  List<String>? members;
  String? idAdmin;
  MemberGroupScreen({super.key, this.members});

  @override
  State<MemberGroupScreen> createState() => _MemberGroupScreenState();
}

class _MemberGroupScreenState extends State<MemberGroupScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FastContactCubit>().FastContactenticate();
  }

  List<FriendsM> filteredMembers = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      HeaderTrans(
        title: "Thành viên",
      ),
      BlocBuilder<FastContactCubit, FastContactState>(
          builder: (context, state) {
        if (state is LoadingFastContactState) {
          return SizedBox(
            height: height - 200.sp,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FastContactFriendsSuccessdState) {
          filteredMembers = state.data
              .where((member) => widget.members?.contains(member.id) ?? false)
              .toList();
          return Wrap(
              children: filteredMembers.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 15.sp),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: entry.value.avatar != ""
                          ? ImageAssets.networkImage(
                              url: entry.value.avatar,
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
                      entry.value.name,
                      style: text15.primary.regular,
                    ),
                  ),
                ],
              ),
            );
          }).toList());
        }
        return Container();
      }),
    ])));
  }
}
