<<<<<<< Updated upstream
=======
import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/screen/boarding/onboarding1.dart';
import 'package:app_zalo/screen/boarding/onboarding2.dart';
import 'package:app_zalo/screen/boarding/onboarding3.dart';
import 'package:app_zalo/widget/button/button_bottom_navigated.dart';
>>>>>>> Stashed changes
import 'package:app_zalo/constants/colors.dart';
import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/screen/boarding/onboarding1.dart';
import 'package:app_zalo/screen/boarding/onboarding2.dart';
import 'package:app_zalo/screen/boarding/onboarding3.dart';
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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
