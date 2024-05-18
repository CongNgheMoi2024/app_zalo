import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SaveTokenFirebase {
  Future<void> saveTokenFirebase() async {
    try {
      String accessToken = HiveStorage().token;
      String? tokenFirebase = await FirebaseMessaging.instance.getToken();

      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/notifications/save-token";
      Response response = await dio.post(apiUrl,
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: {"token": tokenFirebase});
      if (response.statusCode == 200) {
        print(
            "Token Firebase đã được lưu $tokenFirebase, AccessToken: $accessToken");
      } else {
        print("Lỗi SaveTokenFirebase");
      }
    } catch (e) {
      print("Looixiii SaveTokenFirebase $e");
    }
  }
}
