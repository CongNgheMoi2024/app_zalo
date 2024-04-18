import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../env.dart';
import 'get_members_cubit.dart';

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
  Future<List<Member>> getMembers(String idGroup) async {

    String accToken = HiveStorage().token;
    try {
      Dio dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer $accToken";
      Response response = await dio.get(
        "${Env.url}/api/v1/rooms/members/$idGroup",
      );
      if (response.statusCode == 200) {
        String idAdmin = response.data['data']['admin']['id'];
        List<dynamic> subadminsData = response.data['data']['subAdmins'];
        List<String> subAdmins = subadminsData.map((e) => e['id'].toString()).toList();
            
        List<dynamic> membersData = response.data['data']['members'];
        List<Member> members = membersData.map((member) {
          RoleGroup role;
          if (member['id'] == idAdmin) {
            role = RoleGroup.admin;
          } else if (subAdmins.contains(member['id'])) {
            role = RoleGroup.subadmin;
          } else {
            role = RoleGroup.member;
          }
          return Member(
              id: member['id'],
              name: member['name'],
              avatar: member['avatar'] ?? "",
              role: role);
        }).toList();
        // sắp xếp theo role
        members.sort((a, b) => a.role.index.compareTo(b.role.index));
        return members;
      }
      return [];
    } catch (e) {
      print("LỖI TRONG GET MEMBER " + e.toString());
      return [];
    }
  }