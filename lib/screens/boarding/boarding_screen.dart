import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screens/boarding/onboarding1.dart';
import 'package:app_zalo/screens/boarding/onboarding2.dart';
import 'package:app_zalo/screens/boarding/onboarding3.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

PageController _pageController = PageController();

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.83,
            child: PageView(
              controller: _pageController,
              children: [
                Onboarding1(onNextPage: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }),
                Onboarding2(
                  onNextPage: () {
                    _pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
                const Onboarding3(),
              ],
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: primaryColor,
                dotColor: greyIcBot,
                dotHeight: 10.sp,
                dotWidth: 10.sp,
                expansionFactor: 5.sp,
                spacing: 6.sp,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0, -0.73),
            child: SizedBox(
              height: 100.sp,
              child: Text("Zalo",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.22,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: ButtonBottomNavigated(
                title: "Đăng nhập",
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RouterName.loginScreen);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: SizedBox(
                  height: 63.sp,
                  width: width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouterName.phoneOTPRegisterScreen);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 55.sp, right: 55.sp, bottom: 5.sp, top: 8.sp),
                        width: width - 40.sp,
                        decoration: BoxDecoration(
                            color: greyIcBot.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(28.sp)),
                        child: Center(
                          child: Text(
                            "Đăng kí",
                            style: text15.medium.black,
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
