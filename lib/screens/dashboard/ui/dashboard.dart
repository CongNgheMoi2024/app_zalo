import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/create_group/bloc/create_group_cubit.dart';
import 'package:app_zalo/screens/create_group/ui/create_group_screen.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_cubit.dart';
import 'package:app_zalo/screens/fast_contact/ui/fast_contact_screen.dart';
import 'package:app_zalo/screens/home_account/bloc/infor_account_cubit.dart';
import 'package:app_zalo/screens/home_account/ui/home_account_screen.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';
import 'package:app_zalo/screens/home_chat/ui/home_chat_screen.dart';
import 'package:app_zalo/widget/header/header_actions_bar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool isLoading = false;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  Future<void> getContactPermission() async {
    setState(() {
      isLoading = true;
    });
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void showModelCreateGroup() {
    showDialog(
        context: context,
        builder: (context) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return SizedBox(
              height: height,
              width: width,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 63.sp,
                  ),
                  height: height * 0.12,
                  color: whiteColor,
                  child: Column(
                    children: [
                      Container(
                          height: height * 0.06,
                          width: width * 0.33,
                          color: whiteColor,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MultiBlocProvider(providers: [
                                      BlocProvider<FastContactCubit>(
                                        create: (BuildContext context) =>
                                            FastContactCubit(),
                                      ),
                                      BlocProvider<CreateGroupCubit>(
                                        create: (BuildContext context) =>
                                            CreateGroupCubit(),
                                      ),
                                    ], child: const CreateGroupScreen()),
                                  ),
                                );
                              },
                              child: Text(" Tạo nhóm ",
                                  style: text16.primary.regular),
                            ),
                          )),
                      Container(
                        height: height * 0.06,
                        width: width * 0.33,
                        color: whiteColor,
                        child: Center(
                            child: Text("Tạo phòng",
                                style: text16.primary.regular)),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void fetchContacts() async {
    ContactsService.getContacts().then((value) {
      contacts = value.toList();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 63.sp,
        backgroundColor: Colors.transparent,
        flexibleSpace: HeaderActionsBar(
          icon1: _currentIndex == 0 || _currentIndex == 2
              ? Icons.qr_code_scanner_outlined
              : null,
          icon2: _currentIndex == 0 || _currentIndex == 1
              ? Icons.more_vert_outlined
              : null,
          action2: _currentIndex == 0 || _currentIndex == 1
              ? () {
                  showModelCreateGroup();
                }
              : () {},
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  left: 20.sp,
                  right: 10.sp,
                  top: 10.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message_outlined,
                      size: 30.sp,
                      color: _currentIndex == 0
                          ? primaryColor
                          : primaryColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              label: 'Tin nhắn',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.switch_account_outlined,
                      size: 30.sp,
                      color: _currentIndex == 1
                          ? primaryColor
                          : primaryColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              label: 'Danh bạ',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 30.sp,
                      color: _currentIndex == 2
                          ? primaryColor
                          : primaryColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              label: 'Nhật kí',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 10.sp, right: 20.sp, top: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 30.sp,
                      color: _currentIndex == 3
                          ? primaryColor
                          : primaryColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              label: 'Cá nhân',
            ),
          ]),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MultiBlocProvider(providers: [
            BlocProvider<GetAllRoomCubit>(
              create: (BuildContext context) => GetAllRoomCubit(),
            ),
            BlocProvider<GetAllRoomCubit>(
              create: (BuildContext context) => GetAllRoomCubit(),
            ),
          ], child: const HomeChatScreen()),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black)))
              : MultiBlocProvider(
                  providers: [
                    BlocProvider<FastContactCubit>(
                      create: (BuildContext context) => FastContactCubit(),
                    ),
                    BlocProvider<GetFriendsCubit>(
                      create: (BuildContext context) => GetFriendsCubit(),
                    ),
                  ],
                  child: FastContactScreen(contacts: contacts),
                ),
          Container(
            color: Colors.yellow,
            child: const Text("Tính năng đang phát triển"),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider<InforAccountCubit>(
                create: (BuildContext context) => InforAccountCubit(),
              ),
              // BlocProvider<InforAccountCubit>(
              //   create: (BuildContext context) => InforAccountCubit(),
              // ),
            ],
            child: const HomeAccountScreen(),
          ),
        ],
      ),
    ));
  }
}
