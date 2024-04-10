import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/change_password/bloc/change_password_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(InitialChangePasswordState());

  // ignore: non_constant_identifier_names
  Future<void> ChangePassword(String oldPassword, String newPassword,
      String confirmPassword, String phone) async {
    String accessToken = HiveStorage().token;
    emit(LoadingChangePasswordState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/change-password/$phone";

      Response response = await dio.put(apiUrl,
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: {
            "old_password": oldPassword,
            "new_password": newPassword,
            "confirm_password": confirmPassword
          });

      if (response.statusCode == 200) {
        emit(ChangePasswordSuccessState(response.data['message']));
      } else {
        emit(ErrorChangePasswordState(
            "ChangePassword failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorChangePasswordState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialChangePasswordState());
  }
}
