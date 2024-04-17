import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';

class AcceptFriend {
  String idUser = HiveStorage().idUser;
  String accessToken = HiveStorage().token;
  Future<bool> acceptFriend(String idFriend) async {
    try {
      Dio dio = Dio();
      String apiUrl =
          "${Env.url}/api/v1/friend-requests/accept-friend-request/$idFriend/$idUser";

      Response response = await dio.post(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("DDDDfgdsgdg$e");
      return false;
    }
  }
}
