import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FastContactCubit extends Cubit<FastContactState> {
  FastContactCubit() : super(InitialFastContactState());

  // ignore: non_constant_identifier_names
  Future<void> FastContactenticate() async {
    String accessToken = HiveStorage().token;
    emit(LoadingFastContactState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/friends";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        print("LOADDDD THÀNH CÔNG ${response.data['data']}");
        emit(FastContactFriendsSuccessdState(response.data['data']));
      } else {
        emit(ErrorFastContactState("FastContact failed.  "));
      }
    } catch (e) {
      print("Looixiii ${e.toString()}");
      emit(ErrorFastContactState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialFastContactState());
  }
}
