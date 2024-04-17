import 'dart:convert';

import 'package:app_zalo/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storages/hive_storage.dart';
import 'get_members_state.dart';

enum RoleGroup { admin, subadmin, member }

class Member {
  final String id;
  final String name;
  final String avatar;
  final RoleGroup role;
  Member(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.role});
}

class GetMembersCubit extends Cubit<GetMembersState> {
  GetMembersCubit() : super(InitialGetMembersState());
  Future<void> getMembers(String idGroup) async {
    emit(LoadingGetMembersState());
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
        emit(SuccessGetMembersState(members));
      }
    } catch (e) {
      print("LỖI TRONG GET MEMBER CUBIT" + e.toString());
      emit(ErrorGetMembersState(e.toString()));
    }
  }
  void reset(){
    emit(InitialGetMembersState());
  }
}
