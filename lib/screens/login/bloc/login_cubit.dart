import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/login/bloc/login_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  // ignore: non_constant_identifier_names
  Future<void> Loginenticate(String phoneNumber, String password) async {
    emit(LoadingLoginState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/auth/login";

      Response response = await dio
          .post(apiUrl, data: {"phone": phoneNumber, "password": password});
      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data['data'];
        String accessToken = result['access_token'];
        String refreshToken = result['refresh_token'];
        HiveStorage().updateToken(accessToken);
        HiveStorage().updateRefreshToken(refreshToken);
        HiveStorage().updateIdUser(result['user']['id']);

        emit(LoginenticatedState(refreshToken, phoneNumber));
      } else {
        emit(ErrorLoginState("Login failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorLoginState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialLoginState());
  }
}
