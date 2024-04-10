import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/forgot_password/bloc/otp_forgot_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPForgotCubit extends Cubit<OTPForgotPasswordState> {
  OTPForgotCubit() : super(InitialOTPForgotPasswordState());

  // ignore: non_constant_identifier_names
  Future<void> OTPForgotenticate(
      String otp, String password, String confirmPassword, String phone) async {
    emit(LoadingOTPForgotPasswordState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/otp-forget/$phone";

      Response response = await dio.put(apiUrl, data: {
        "otp": otp,
        "password": password,
        "confirm_password": confirmPassword
      });

      if (response.statusCode == 200) {
        emit(SuccessOTPForgotState(otp));
      } else {
        emit(ErrorOTPForgotPasswordState(
            "OTPForgot failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorOTPForgotPasswordState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialOTPForgotPasswordState());
  }
}
