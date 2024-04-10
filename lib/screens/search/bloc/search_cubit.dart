import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/search/bloc/search_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitSearchState());
  Future<void> search(String phone) async {
    emit(LoadingSearchState());
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/$phone";
      Map<String, String> headers = {
        'Authorization': 'Bearer ${HiveStorage().token}',
      };
      Options options = Options(headers: headers);
      Response response = await dio.get(apiUrl, options: options);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        emit(SuccessSearchState(response.statusCode!, data));
      } else {
        emit(ErrorSearchState(response.statusCode!, response.data['message']));
      }
    } catch (error) {
      emit(ErrorSearchState(0, error.toString()));
    }
  }

  void resetState() {
    emit(InitSearchState());
  }
}
