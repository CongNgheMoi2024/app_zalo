import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsM {
  final String id;
  final String name;
  final String phone;
  final String avatar;

  FriendsM(
      {required this.id,
      required this.name,
      required this.phone,
      required this.avatar});

  factory FriendsM.fromJson(Map<String, dynamic> json) {
    return FriendsM(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
    );
  }
}

class FastContactCubit extends Cubit<FastContactState> {
  FastContactCubit() : super(InitialFastContactState());
  String accessToken = HiveStorage().token;
  // ignore: non_constant_identifier_names
  Future<void> FastContactenticate() async {
    emit(LoadingFastContactState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/friends";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        emit(FastContactFriendsSuccessdState((response.data["data"] as List)
            .map((e) => FriendsM.fromJson(e))
            .toList()));
      } else {
        emit(ErrorFastContactState("FastContact failed.  "));
      }
    } catch (e) {
      emit(ErrorFastContactState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialFastContactState());
  }
}
