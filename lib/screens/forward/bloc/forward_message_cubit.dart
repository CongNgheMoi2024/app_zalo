import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/forward/bloc/forward_message_state.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForwardMessageCubit extends Cubit<ForwardMessageState> {
  ForwardMessageCubit() : super(InitialForwardMessageState());

  Future<void> forwardMessageenticate(
      List<String> listUser, String idMessage) async {
    String accToken = HiveStorage().token;
    emit(LoadingForwardMessageState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/forward-messages/$idMessage";

      Response response = await dio.post(apiUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accToken",
          }),
          data: listUser);
      if (response.statusCode == 200) {
        emit(ForwardSuccessState());
      } else {
        emit(ErrorForwardMessageState("ForwardMessage failed. }"));
      }
    } catch (e) {
      print("Looixiii ${e.toString()}");
      emit(ErrorForwardMessageState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialForwardMessageState());
  }
}
