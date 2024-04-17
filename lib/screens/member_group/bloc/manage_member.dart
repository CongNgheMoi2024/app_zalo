import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../env.dart';

final String accToken = HiveStorage().token;

Future<bool> grantSubAdmin(String idGroup, String idUser) async {
  try {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $accToken";
    Response response = await dio.put(
      "${Env.url}/api/v1/add-sub-admin/$idGroup/$idUser",
    );
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> revokeSubAdmin(String idGroup, String idUser) async {
  try {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $accToken";
    Response response = await dio.put(
      "${Env.url}/api/v1/remove-sub-admin/$idGroup/$idUser",
    );
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> transferAdmin(String idGroup, String idUser) async {
  try {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $accToken";
    Response response = await dio.put(
      "${Env.url}/api/v1/rooms/$idGroup/change-admin/$idUser",
    );
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}
