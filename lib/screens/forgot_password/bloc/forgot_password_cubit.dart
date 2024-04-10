import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/forgot_password/bloc/forgot_password_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(InitialForgotPasswordState());

  // ignore: non_constant_identifier_names
  Future<void> ForgotPasswordenticate(String phoneNumber) async {
    emit(LoadingForgotPasswordState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/forget-password";

      Response response = await dio
          .post(apiUrl, data: {"phoneNo": "+84${phoneNumber.substring(1)}"});

      if (response.statusCode == 200) {
        emit(ForgotPasswordenticatedState(phoneNumber));
      } else {
        emit(ErrorForgotPasswordState(
            "ForgotPassword failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorForgotPasswordState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialForgotPasswordState());
  }
}
