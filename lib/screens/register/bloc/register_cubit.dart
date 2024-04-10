import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/register/bloc/register_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  Future<void> register(String numberPhone, String name, int sex,
      String dateOfBirth, String password, String confirmPassword) async {
    emit(LoadingRegisterState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/auth/register";
      Response response = await dio.post(apiUrl, data: {
        "name": name,
        "password": password,
        "retype_password": confirmPassword,
        "phone": numberPhone,
        "sex": sex,
        "birthday": dateOfBirth,
        "role_id": "1"
      });

      if (response.statusCode == 200) {
        HiveStorage().updateToken("${response.data['data']['access_token']}");
        HiveStorage()
            .updateRefreshToken("${response.data['data']['refresh_token']}");
        HiveStorage().updateIdUser(response.data['data']['user']['id']);
        emit(SuccessRegisterState());
      } else {
        emit(
            ErrorRegisterState(response.statusCode!, response.data['message']));
      }
    } catch (e) {
      emit(ErrorRegisterState(0, e.toString()));
    }
  }

  void resetState() {
    emit(InitialRegisterState());
  }
}
