import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';

class AcceptFriend {
  String idUser = HiveStorage().idUser;
  String accessToken = HiveStorage().token;
  Future<bool> acceptFriend(String idFriend) async {
    print("DDDDDDDDDDDD $idFriend  ");
    try {
      Dio dio = Dio();
      String apiUrl =
          "${Env.url}/api/v1/friend-requests/accept-friend-request/$idFriend/$idUser";

      Response response = await dio.post(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        print("DDDDDDDDDDDD ${response.data['message']}");
        return true;
      } else {
        print("DDD333DDD ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("DDDDfgdsgdg$e");
      return false;
    }
  }
}
