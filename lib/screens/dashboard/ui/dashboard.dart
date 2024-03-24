import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/fast_contact/fast_contact_screen.dart';
import 'package:app_zalo/screens/home_account/bloc/infor_account_cubit.dart';
import 'package:app_zalo/screens/home_account/home_account_screen.dart';
import 'package:app_zalo/screens/home_chat/home_chat_screen.dart';
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
            icon2: _currentIndex == 0 || _currentIndex == 1 ? Icons.add : null,
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
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                label: 'Tin nhắn',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:
                      EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.switch_account_outlined,
                        size: 30.sp,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                label: 'Danh bạ',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:
                      EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 30.sp,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                label: 'Nhật kí',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:
                      EdgeInsets.only(left: 10.sp, right: 20.sp, top: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30.sp,
                        color: primaryColor,
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
            const HomeChatScreen(),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black)))
                : FastContactScreen(contacts: contacts),
            Container(
              color: Colors.yellow,
              child: Text("Text1"),
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
      ),
    );
  }
}
