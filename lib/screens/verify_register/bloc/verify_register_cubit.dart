import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/verify_register/bloc/verify_register_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  VerifyRegisterCubit() : super(InitialVerifyRegisterState());

  // ignore: non_constant_identifier_names
  Future<void> VerifyRegisterenticate(
    String otp,
  ) async {
    emit(LoadingVerifyRegisterState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/otp";
      dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(apiUrl, data: {
        {"otp": 415566}
      });

      if (response.statusCode == 200) {
        print("OTPP đúng rồiii");
        emit(VerifyRegisterSuccessState());
      } else {
        emit(ErrorVerifyRegisterState(
            "VerifyRegister failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorVerifyRegisterState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialVerifyRegisterState());
  }
}
