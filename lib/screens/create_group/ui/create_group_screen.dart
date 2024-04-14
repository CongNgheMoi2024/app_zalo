import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:app_zalo/widget/dismiss_keyboard_widget.dart';
import 'package:app_zalo/widget/header/header_back.dart';
import 'package:app_zalo/widget/text_input/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FastContactCubit>().FastContactenticate();
  }

  List<dynamic> listFriend = [];
  @override
  Widget build(BuildContext context) {
    print("CreateGroupScreen build $listFriend");
    return DismissKeyboard(
        child: SafeArea(
            child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<FastContactCubit, FastContactState>(
                        builder: (context, stateFastContact) {
                      if (stateFastContact is FastContactFriendsSuccessdState) {
                        print("asafafsff ${stateFastContact.data}");
                      }
                      return Container();
                    }),
                    HeaderBack(
                      title: "Tạo nhóm",
                      notCheck: true,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.sp),
                          child: Icon(
                            Icons.group_add_outlined,
                            color: primaryColor.withOpacity(0.5),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Nhập tên nhóm",
                              hintStyle: TextStyle(
                                color: primaryColor.withOpacity(0.6),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 12.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextInputWidget(
                      title: "Tìm bạn bè theo tên",
                      onTextChanged: (value) {
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          print("Refreshed");
                        },
                        child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Container()),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                    height: 100.sp,
                    padding: EdgeInsets.only(bottom: 36.sp),
                    child: Column(
                      children: [
                        ButtonBottomNavigated(
                          title: "Tạo nhóm",
                          onPressed: () {},
                        ),
                      ],
                    )))));
  }
}
