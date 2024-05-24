import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/add_member_group/bloc/add_member_cubit.dart';
import 'package:app_zalo/screens/add_member_group/bloc/add_member_state.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddMemberGroupScreen extends StatefulWidget {
  String? idGroup;
  Function? sendAddMember;

  AddMemberGroupScreen({super.key, this.idGroup, this.sendAddMember});

  @override
  State<AddMemberGroupScreen> createState() => _AddMemberGroupScreenState();
}

class _AddMemberGroupScreenState extends State<AddMemberGroupScreen> {
  String? filter = '';
  List<String> members = [];

  Future<void> getMembers(String idGroup) async {
    String accToken = HiveStorage().token;
    try {
      Dio dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer $accToken";
      Response response = await dio.get(
        "${Env.url}/api/v1/rooms/members/$idGroup",
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        var memberList = data['members'] as List;
        setState(() {
          members = memberList.map((member) => member['id'] as String).toList();
        });
      } else {
        print("LỖI 444444444 TRONG GET MEMBER CUBIT ${response.data}");
      }
    } catch (e) {
      print("LỖI TRONG GET MEMBER CUBIT $e");
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FastContactCubit>().FastContactenticate();
  }

  List<String> listIdFriends = [];
  List<bool> listChecked = [];
  List<String> selectedIds = [];
  @override
  Widget build(BuildContext context) {
    getMembers(widget.idGroup!);
    double width = MediaQuery.of(context).size.width;
    return DismissKeyboard(
        child: SafeArea(
            child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderTrans(
                      title: "Thêm thành viên",
                      notCheck: true,
                    ),
                    SizedBox(
                      height: 35.sp,
                    ),
                    TextInputWidget(
                      title: "Tìm bạn bè theo tên",
                      onTextChanged: (value) {
                        setState(() {
                          filter = value;
                        });
                      },
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          print("Refreshed");
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child:
                              BlocBuilder<FastContactCubit, FastContactState>(
                                  builder: (context, stateFastContact) {
                            if (stateFastContact is LoadingFastContactState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (stateFastContact
                                is FastContactFriendsSuccessdState) {
                              return Wrap(
                                  children: stateFastContact.data
                                      .where((element) => element.name
                                          .toLowerCase()
                                          .contains(filter!.toLowerCase()))
                                      .toList()
                                      .asMap()
                                      .entries
                                      .map<Widget>(
                                (entry) {
                                  List.generate(stateFastContact.data.length,
                                      (index) {
                                    listChecked.add(false);
                                    listIdFriends
                                        .add(stateFastContact.data[index].id);
                                  });
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.sp,
                                                    right: 10.sp,
                                                    top: 12.sp,
                                                    bottom: 12.sp),
                                                child: Checkbox(
                                                  checkColor: whiteColor,
                                                  activeColor: members.contains(
                                                          entry.value.id)
                                                      ? primaryColor
                                                          .withOpacity(0.6)
                                                      : primaryColor,
                                                  value: members.contains(
                                                          entry.value.id)
                                                      ? true
                                                      : listChecked[entry.key],
                                                  onChanged: (value) {
                                                    members.contains(
                                                            entry.value.id)
                                                        ? null
                                                        : setState(() {
                                                            listChecked[entry
                                                                .key] = value!;
                                                          });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.sp,
                                                    top: 12.sp,
                                                    bottom: 12.sp),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: entry.value.avatar ==
                                                          ""
                                                      ? ImageAssets.pngAsset(
                                                          Png.imgUserBoy,
                                                          width: 35.sp,
                                                          height: 35.sp,
                                                          fit: BoxFit.cover)
                                                      : ImageAssets
                                                          .networkImage(
                                                              url: entry
                                                                  .value.avatar,
                                                              width: 35.sp,
                                                              height: 35.sp,
                                                              fit:
                                                                  BoxFit.cover),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  entry.value.name,
                                                  style: members.contains(
                                                          entry.value.id)
                                                      ? text16.medium.copyWith(
                                                          color: primaryColor
                                                              .withOpacity(0.6))
                                                      : text16.medium.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 0.5.sp,
                                          width: width,
                                          color: grey03.withOpacity(0.5),
                                          margin: EdgeInsets.only(left: 105.sp),
                                        )
                                      ]);
                                },
                              ).toList());
                            }
                            return const Center(
                              child: Text("Không có dữ liệu"),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                    height: 100.sp,
                    padding: EdgeInsets.only(bottom: 16.sp),
                    child: BlocBuilder<AddMemberCubit, AddMemberState>(
                        builder: (context, state) {
                      if (state is AddMemberSuccessState) {
                        widget.sendAddMember!();
                        Future.delayed(Duration.zero, () {
                          selectedIds.clear();
                          listIdFriends.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                        return const SizedBox();
                      } else if (state is LoadingAddMemberState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                          children: [
                            ButtonBottomNavigated(
                              title: "Thêm",
                              isValidate: listChecked.contains(true),
                              onPressed: () {
                                for (int i = 0; i < listIdFriends.length; i++) {
                                  if (listChecked.length > i &&
                                      listChecked[i]) {
                                    selectedIds.add(listIdFriends[i]);
                                  }
                                }
                                HiveStorage().updateListMembers(selectedIds);
                                context
                                    .read<AddMemberCubit>()
                                    .addMembersToGroup(
                                        widget.idGroup!, selectedIds)
                                    .then((value) => {});
                              },
                            ),
                            state is ErrorAddMemberState
                                ? Text(
                                    "Không thể thể thêm User này vào nhóm",
                                    style: text15.error.medium,
                                  )
                                : const SizedBox(),
                          ],
                        );
                      }
                    })))));
  }
}
