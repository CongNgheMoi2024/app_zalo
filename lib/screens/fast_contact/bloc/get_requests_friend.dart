import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';

class UserRequest {
  String? id;
  String? name;
  String? avatar;
  String? phone;
  String? idUser;

  UserRequest({this.id, this.name, this.avatar, this.phone, this.idUser});

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    var fromUser = json['fromUser'];
    return UserRequest(
      id: json['id'],
      idUser: fromUser != null ? fromUser['id'] : null,
      name: fromUser != null ? fromUser['name'] : null,
      avatar: fromUser != null ? fromUser['avatar'] : null,
      phone: fromUser != null ? fromUser['phone'] : null,
    );
  }
}

class GetRequestFriend {
  String idUser = HiveStorage().idUser;
  String accessToken = HiveStorage().token;
  Future<List<UserRequest>> getRequestFriend() async {
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/friend-requests/invitation/$idUser";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        List<UserRequest> listUserRequest = [];
        for (var item in response.data['data']) {
          listUserRequest.add(UserRequest.fromJson(item));
        }
        return listUserRequest;
      } else {
        return [];
      }
    } catch (e) {
      print("DDDDDDDDDDDD $e");
      return [];
    }
  }
}
