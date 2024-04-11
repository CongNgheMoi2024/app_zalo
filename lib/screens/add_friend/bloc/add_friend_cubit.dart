import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/add_friend/bloc/add_friend_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(InitialAddFriendState());

  // ignore: non_constant_identifier_names
  Future<void> addFriends(String idFriend) async {
    emit(LoadingAddFriendState());
    String idUser = HiveStorage().idUser;
    String accessToken = HiveStorage().token;

    try {
      Dio dio = Dio();
      String apiUrl =
          "${Env.url}/api/v1/friend-requests/send-friend-request/$idUser/$idFriend";

      Response response = await dio.post(apiUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          }));
      if (response.statusCode == 200) {
        print("Gui Ket Ban Thanh Cong");
        emit(AddFriendSuccessState());
      } else {
        emit(ErrorAddFriendState("Gui Ket Ban That Bai"));
      }
    } catch (e) {
      emit(ErrorAddFriendState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialAddFriendState());
  }
}
