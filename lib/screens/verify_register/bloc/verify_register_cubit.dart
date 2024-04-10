import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/verify_register/bloc/verify_register_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  VerifyRegisterCubit() : super(InitialVerifyRegisterState());

  // ignore: non_constant_identifier_names
  Future<void> VerifyRegisterenticate(
    String phoneNumber,
    String otp,
  ) async {
    emit(LoadingVerifyRegisterState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/otp";
      Response response = await dio.post(apiUrl,
          data: {"phoneNo": "+84${phoneNumber.substring(1)}", "otp": otp});

      if (response.statusCode == 200) {
        emit(VerifyRegisterSuccessState(phoneNumber));
      } else {
        emit(ErrorVerifyRegisterState("VerifyRegister failed."));
      }
    } catch (e) {
      emit(ErrorVerifyRegisterState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialVerifyRegisterState());
  }
}
