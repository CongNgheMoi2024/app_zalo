import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screens/home_account/home_account_screen.dart';
import 'package:app_zalo/screens/home_chat/home_chat_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

List<bool> isSelectedB = [true, false, false, false];

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Theme(
            data: ThemeData(useMaterial3: false),
            child: BottomAppBar(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    height: 75.sp,
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectedB = [
                                  true,
                                  false,
                                  false,
                                  false,
                                ];
                              });
                              _tabController.animateTo(0);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.sp,
                                  right: 10.sp,
                                  top: 10.sp,
                                  bottom: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    size: 30.sp,
                                    color: isSelectedB[0] == true
                                        ? primaryColor
                                        : greyIcBot.withOpacity(0.5),
                                  ),
                                  Text(
                                    'Tin nhắn',
                                    style: text14.copyWith(
                                      color: isSelectedB[0] == true
                                          ? primaryColor
                                          : greyIcBot.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectedB = [
                                  false,
                                  true,
                                  false,
                                  false,
                                ];
                              });
                              _tabController.animateTo(1);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.sp,
                                  right: 15.sp,
                                  top: 10.sp,
                                  bottom: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.switch_account_outlined,
                                    size: 30.sp,
                                    color: isSelectedB[1] == true
                                        ? primaryColor
                                        : greyIcBot.withOpacity(0.5),
                                  ),
                                  Text(
                                    'Danh bạ',
                                    style: text14.copyWith(
                                      color: isSelectedB[1] == true
                                          ? primaryColor
                                          : greyIcBot.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectedB = [
                                  false,
                                  false,
                                  true,
                                  false,
                                ];
                              });
                              _tabController.animateTo(2);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.sp,
                                  right: 15.sp,
                                  top: 10.sp,
                                  bottom: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 30.sp,
                                    color: isSelectedB[2] == true
                                        ? primaryColor
                                        : greyIcBot.withOpacity(0.5),
                                  ),
                                  Text(
                                    'Nhật kí',
                                    style: text14.copyWith(
                                      color: isSelectedB[2] == true
                                          ? primaryColor
                                          : greyIcBot.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectedB = [
                                  false,
                                  false,
                                  false,
                                  true,
                                ];
                              });
                              _tabController.animateTo(3);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.sp,
                                  right: 20.sp,
                                  top: 10.sp,
                                  bottom: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_circle_outlined,
                                    size: 30.sp,
                                    color: isSelectedB[3] == true
                                        ? primaryColor
                                        : greyIcBot.withOpacity(0.5),
                                  ),
                                  Text(
                                    'Cá nhân',
                                    style: text14.copyWith(
                                        color: isSelectedB[3] == true
                                            ? primaryColor
                                            : greyIcBot.withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ])))),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            const HomeChatScreen(),
            Container(
              color: Colors.blue,
              child: Text("Text1"),
            ),
            Container(
              color: Colors.yellow,
              child: Text("Text1"),
            ),
            const HomeAccountScreen(),
          ],
        ));
  }
}
