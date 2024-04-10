import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/fast_contact/bloc/get_friends_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFriendsCubit extends Cubit<GetFriendsState> {
  GetFriendsCubit() : super(InitialGetFriendsState());
  String accessToken = HiveStorage().token;

  Future<void> getFriendsPhoneBook() async {
    emit(LoadingGetFriendsPhoneBookState());
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/phone-book/friends";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        emit(GetFriendsPhoneBookSuccessState(response.data['data']));
      } else {
        emit(ErrorGetFriendsPhoneBookState("GetFriends failed.  "));
      }
    } catch (e) {
      emit(ErrorGetFriendsPhoneBookState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialGetFriendsState());
  }
}
