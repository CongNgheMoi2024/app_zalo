import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/more_chatting/bloc/delete_room_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteRoomCubit extends Cubit<DeleteRoomState> {
  DeleteRoomCubit() : super(InitialDeleteRoomState());

  // ignore: non_constant_identifier_names
  Future<void> deleteGroup(String idGroup) async {
    // emit(LoadingDeleteRoomState());
    String accessToken = HiveStorage().token;

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/delete-room/$idGroup";

      Response response = await dio.delete(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      print("Response delete room $response");
      if (response.statusCode == 200) {
        emit(DeleteRoomSuccessState());
      } else {
        print("Erroooooor ${response.data['message']}");
        emit(ErrorDeleteRoomState("DeleteRoom failed. "));
      }
    } catch (e) {
      print("Error delete room $e");
      emit(ErrorDeleteRoomState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialDeleteRoomState());
  }
}
