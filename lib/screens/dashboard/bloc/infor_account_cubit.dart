import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/dashboard/bloc/infor_account_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InforAccountCubit extends Cubit<InforAccountState> {
  InforAccountCubit() : super(InitialInforAccountState());

  // ignore: non_constant_identifier_names
  Future<void> GetInforAccount(String phoneNumber) async {
    emit(LoadingInforAccountState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/$phoneNumber";

      Response response = await dio.get(apiUrl,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));

      if (response.statusCode == 200) {
        print("GetttThanhhhcoonggggggggg");
        // emit(InforAccountSuccessState( "IDUSSER",phoneNumber,));
      } else {
        emit(ErrorInforAccountState(
            "InforAccount failed. ${response.data['message']}"));
      }
    } catch (e) {
      print("Looixiii ${e.toString()}");
      emit(ErrorInforAccountState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialInforAccountState());
  }
}
