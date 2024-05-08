import 'package:app_zalo/screens/boarding/boarding_screen.dart';
import 'package:app_zalo/screens/dashboard/ui/dashboard.dart';
import 'package:app_zalo/screens/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:app_zalo/screens/forgot_password/ui/forgot_password_screen.dart';
import 'package:app_zalo/screens/login/bloc/login_cubit.dart';
import 'package:app_zalo/screens/login/ui/login_screen.dart';
import 'package:app_zalo/screens/register/bloc/phone_otp_regis_cubit.dart';
import 'package:app_zalo/screens/register/ui/phone_otp_regis_screen.dart';
import 'package:app_zalo/screens/search/bloc/search_cubit.dart';
import 'package:app_zalo/screens/search/ui/search_by_phone_screen.dart';
import 'package:app_zalo/screens/splash/splash_screen.dart';
import 'package:app_zalo/screens/upload_avatar/bloc/upload_avatar_cubit.dart';
import 'package:app_zalo/screens/upload_avatar/ui/upload_avatar_screen.dart';
import 'package:app_zalo/screens/upload_cover_image/bloc/upload_cover_cubit.dart';
import 'package:app_zalo/screens/upload_cover_image/ui/upload_cover_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;
    switch (name) {
      case RouterName.initScreen:
        screen = const SplashScreen();
        break;

      case RouterName.dashboardScreen:
        screen = const DashboardScreen();
        break;

      case RouterName.onBoardingScreen:
        screen = const BoardingScreen();

        break;

      case RouterName.phoneOTPRegisterScreen:
        screen = BlocProvider(
            create: (context) => PhoneOtpRegisCubit(),
            child: const PhoneOTPRegisterScreen());
        break;
      case RouterName.uploadAvatarScreen:
        screen = BlocProvider(
            create: (context) => UploadAvatarCubit(),
            child: const UploadAvatarScreen());
        break;

      case RouterName.loginScreen:
        screen = BlocProvider(
            create: (context) => LoginCubit(), child: const LoginScreen());
        break;

      case RouterName.uploadImageCoverScreen:
        screen = BlocProvider(
            create: (context) => UploadCoverCubit(),
            child: const UploadCoverImageScreen());
        break;

      case RouterName.forgotPasswordScreen:
        screen = BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: const ForgotPasswordScreen());
        break;

      case RouterName.searchByPhoneScreen:
        screen = BlocProvider(
            create: (context) => SearchCubit(), child: const SearchScreen());

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
  static const String loginScreen = '/loginScreen';
  static const String uploadImageCoverScreen = '/uploadImageCoverScreen';
  static const String uploadAvatarScreen = '/uploadAvatarScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String searchByPhoneScreen = '/searchByPhoneScreen';
  static const String phoneOTPRegisterScreen = '/phoneOTPRegisterScreen';
  static const String chatScreen = '/chatScreen';
}
