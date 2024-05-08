import 'dart:math';

import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/add_member_group/bloc/add_member_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(InitialAddMemberState());

  Future<void> addMembersToGroup(String idGroup, List<String> members) async {
    String accessToken = HiveStorage().token;
    emit(LoadingAddMemberState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/rooms/$idGroup/add-members";

      print("Members: $members");
      Response response = await dio.put(apiUrl,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json"
          }),
          data: members);

      if (response.statusCode == 200) {
        emit(AddMemberSuccessState(members));
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
