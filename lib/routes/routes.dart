import 'package:app_zalo/screen/boarding/boarding_screen.dart';
import 'package:app_zalo/screen/dashboard/ui/dashboard.dart';
import 'package:app_zalo/screen/register/ui/register_screen.dart';
import 'package:app_zalo/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;

    switch (name) {
      case RouterName.initScreen:
        // screen = SplashScreen();
        // screen = DashboardScreen();
        screen = BoardingScreen();
        break;

      case RouterName.dashboardScreen:
        screen = DashboardScreen();
        break;

      // case RouterName.changePasswordScreen:
      //   screen = BlocProvider(
      //       create: (context) => ChangePasswordCubit(),
      //       child: ChangePasswordScreen());
      //   break;

      // case RouterName.updateInfoAccount:
      //   screen = MultiBlocProvider(
      //     providers: [
      //       BlocProvider<UpdateAccountCubit>(
      //         create: (BuildContext context) => UpdateAccountCubit(),
      //       ),
      //       BlocProvider<ProvinceCubit>(
      //         create: (BuildContext context) =>
      //             ProvinceCubit(ProvinceRepository()),
      //       ),
      //     ],
      //     child: UpdateInfoAccount(),
      //   );
      //   break;

      case RouterName.onBoardingScreen:
        screen = BoardingScreen();
        break;

      case RouterName.registerScreen:
        screen = RegisterScreen();
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
}
