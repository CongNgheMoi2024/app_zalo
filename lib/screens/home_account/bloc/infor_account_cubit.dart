import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/home_account/bloc/infor_account_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InforAccountCubit extends Cubit<InforAccountState> {
  InforAccountCubit() : super(InitialInforAccountState());

  // ignore: non_constant_identifier_names
  Future<void> GetInforAccount() async {
    String accessToken = HiveStorage().token;
    emit(LoadingInforAccountState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/profile";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        emit(InforAccountSuccessState(
          response.data['data'],
          response.data['data']['phone'],
          response.data['data']['avatar'] ?? "",
          response.data['data']['imageCover'] ?? "",
        ));
      } else {
        emit(ErrorInforAccountState(
            "InforAccount failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorInforAccountState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialInforAccountState());
  }
}
