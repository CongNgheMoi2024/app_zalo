import 'package:app_zalo/screens/boarding/boarding_screen.dart';
import 'package:app_zalo/screens/dashboard/ui/dashboard.dart';
import 'package:app_zalo/screens/login/ui/login_screen.dart';
import 'package:app_zalo/screens/register/ui/register_screen.dart';
import 'package:app_zalo/screens/splash/splash_screen.dart';
import 'package:app_zalo/screens/upload_avatar/upload_avatar_screen.dart';
import 'package:app_zalo/screens/verify_register/verify_register_screen.dart';
import 'package:flutter/material.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;

    switch (name) {
      case RouterName.initScreen:
        screen = const BoardingScreen();
        break;

      case RouterName.dashboardScreen:
        screen = const DashboardScreen();
        break;

      case RouterName.onBoardingScreen:
        screen = BoardingScreen();
        break;

      case RouterName.registerScreen:
        screen = RegisterScreen();
        break;
      case RouterName.verifyRegisterScreen:
        screen = VerifyRegisterScreen();
        break;
      case RouterName.uploadAvatarScreen:
        screen = const UploadAvatarScreen();
        break;

      case RouterName.loginScreen:
        screen = LoginScreen();
        break;

      default:
        screen = const SplashScreen();
        break;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  };
}

abstract class RouterName {
  static const String initScreen = '/';
  static const String dashboardScreen = '/dashboardScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String registerScreen = '/registerScreen';
  static const String loginScreen = '/loginScreen';
  static const String verifyRegisterScreen = '/verifyRegisterScreen';
  static const String uploadAvatarScreen = '/uploadAvatarScreen';
}
