import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/create_group/bloc/create_group_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(InitialCreateGroupState());

  // ignore: non_constant_identifier_names
  Future<void> createGroup(String nameGroup, List<String> listMembers) async {
    String accessToken = HiveStorage().token;
    emit(LoadingCreateGroupState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/rooms/create-room-group";

      Response response = await dio.post(apiUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          }),
          data: {"groupName": nameGroup, "members": listMembers});
      if (response.statusCode == 200) {
        emit(CreateGroupSuccessdState());
      } else {
        emit(ErrorCreateGroupState("CreateGroup failed."));
      }
    } catch (e) {
      emit(ErrorCreateGroupState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialCreateGroupState());
  }
}
