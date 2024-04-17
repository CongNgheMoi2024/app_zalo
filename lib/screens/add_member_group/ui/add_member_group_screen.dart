import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_trans.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddMemberGroupScreen extends StatefulWidget {
  List<String>? members;
  AddMemberGroupScreen({super.key, this.members});

  @override
  State<AddMemberGroupScreen> createState() => _AddMemberGroupScreenState();
}

class _AddMemberGroupScreenState extends State<AddMemberGroupScreen> {
  TextEditingController textNameGroupController = TextEditingController();
  String? filter = '';
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
    double width = MediaQuery.of(context).size.width;
    print("List id friends: ${widget.members}");
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
                child: BlocBuilder<FastContactCubit, FastContactState>(
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
                        List.generate(stateFastContact.data.length, (index) {
                          listChecked.add(false);
                          listIdFriends.add(stateFastContact.data[index].id);
                        });
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        activeColor: widget.members != null &&
                                                widget.members!
                                                    .contains(entry.value.id)
                                            ? primaryColor.withOpacity(0.6)
                                            : primaryColor,
                                        value: widget.members != null &&
                                                widget.members!
                                                    .contains(entry.value.id)
                                            ? true
                                            : listChecked[entry.key],
                                        onChanged: (value) {
                                          widget.members != null &&
                                                  widget.members!
                                                      .contains(entry.value.id)
                                              ? null
                                              : setState(() {
                                                  listChecked[entry.key] =
                                                      value!;
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
                                        borderRadius: BorderRadius.circular(60),
                                        child: entry.value.avatar == ""
                                            ? ImageAssets.pngAsset(
                                                Png.imgUserBoy,
                                                width: 35.sp,
                                                height: 35.sp,
                                                fit: BoxFit.cover)
                                            : ImageAssets.networkImage(
                                                url: entry.value.avatar,
                                                width: 35.sp,
                                                height: 35.sp,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        entry.value.name,
                                        style: widget.members != null &&
                                                widget.members!
                                                    .contains(entry.value.id)
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
      bottomNavigationBar: ButtonBottomNavigated(
        title: "Tạo nhóm",
        onPressed: () {
          for (int i = 0; i < listIdFriends.length; i++) {
            if (listChecked.length > i && listChecked[i]) {
              selectedIds.add(listIdFriends[i]);
            }
          }
          print("Selected Ids: $selectedIds");
          selectedIds.clear();
          listChecked.clear();
          listIdFriends.clear();
        },
      ),
      // bottomNavigationBar: Container(
      //     height: 100.sp,
      //     padding: EdgeInsets.only(bottom: 16.sp),
      //     child: BlocBuilder<CreateGroupCubit, CreateGroupState>(
      //         builder: (context, state) {
      //       if (state is CreateGroupSuccessdState) {
      //         Future.delayed(Duration.zero, () {
      //           Navigator.pushReplacementNamed(
      //               context, RouterName.dashboardScreen);
      //         });
      //         return const SizedBox();
      //       } else if (state is LoadingCreateGroupState) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else {
      //         return Column(
      //           children: [
      //             ButtonBottomNavigated(
      //               title: "Tạo nhóm",
      //               isValidate: textNameGroupController
      //                       .text.isNotEmpty &&
      //                   textNameGroupController.text.isNotEmpty &&
      //                   listChecked
      //                           .where((element) => element == true)
      //                           .length >=
      //                       2,
      //               onPressed: () {
      //                 for (int i = 0; i < listIdFriends.length; i++) {
      //                   if (listChecked.length > i &&
      //                       listChecked[i]) {
      //                     selectedIds.add(listIdFriends[i]);
      //                   }
      //                 }

      //                 context
      //                     .read<CreateGroupCubit>()
      //                     .createGroup(textNameGroupController.text,
      //                         selectedIds)
      //                     .then((value) => {
      //                           selectedIds.clear(),
      //                           listChecked.clear(),
      //                           listIdFriends.clear()
      //                         });
      //               },
      //             ),
      //             state is ErrorCreateGroupState
      //                 ? Text(
      //                     "Không thể tạo group lúc này",
      //                     style: text15.error.medium,
      //                   )
      //                 : const SizedBox(),
      //           ],
      //         );
      //       }
      //     }))
    )));
  }
}
