import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/more_chatting/bloc/delete_room_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteRoomCubit extends Cubit<DeleteRoomState> {
  DeleteRoomCubit() : super(InitialDeleteRoomState());

  // ignore: non_constant_identifier_names
  Future<void> DeleteRoomenticate(String idRoom) async {
    emit(LoadingDeleteRoomState());
    String accessToken = HiveStorage().token;

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/delete-room/$idRoom";

      Response response = await dio.delete(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        print("XOOOOOOOOOOOOOOOOAAAA thanh cong");
        emit(DeleteRoomSuccessState());
      } else {
        print(" that bai");
        emit(ErrorDeleteRoomState("DeleteRoom failed.}"));
      }
    } catch (e) {
      print("XOAA $e");
      emit(ErrorDeleteRoomState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialDeleteRoomState());
  }
}
