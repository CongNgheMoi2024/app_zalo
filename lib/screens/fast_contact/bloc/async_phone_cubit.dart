import 'dart:convert';

import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/fast_contact/bloc/async_phone_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncPhoneBookCubit extends Cubit<AsyncPhoneBookState> {
  AsyncPhoneBookCubit() : super(InitialAsyncPhoneBookState());

  // ignore: non_constant_identifier_names
  Future<void> AsyncPhoneBookenticate(List<Contact> data) async {
    String accessToken = HiveStorage().token;
    emit(LoadingAsyncPhoneBookState());

    Map<String, dynamic> contactToJson(Contact contact) {
      return {
        'phone': contact.phones!.first.value!,
        'name': contact.displayName,
      };
    }

    try {
      contactToJson(data[0]);
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/phone-books";

      List<Map<String, dynamic>> jsonDataList =
          data.map((contact) => contactToJson(contact)).toList();

      // Encode the List<Map> to JSON
      String jsonData = jsonEncode(jsonDataList);

      Response response = await dio.post(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
        data: jsonData,
      );
      if (response.statusCode == 200) {
        emit(AsyncSuccessState("Đồng bộ thành công"));
      } else {
        emit(ErrorAsyncPhoneBookState("AsyncPhoneBook failed."));
      }
    } catch (e) {
      emit(ErrorAsyncPhoneBookState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialAsyncPhoneBookState());
  }
}
