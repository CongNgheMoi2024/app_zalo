import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/add_member_group/bloc/add_member_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(InitialAddMemberState());

  Future<void> addMembersToGroup() async {
    String accessToken = HiveStorage().token;
    String idUser = HiveStorage().idUser;
    emit(LoadingAddMemberState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/rooms/user/$idUser";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
      } else {
        emit(ErrorAddMemberState("Error GET ALL ROOMS USER"));
      }
    } catch (e) {
      emit(ErrorAddMemberState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialAddMemberState());
  }
}
