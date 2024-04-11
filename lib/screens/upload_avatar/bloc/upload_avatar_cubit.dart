import 'dart:io';

import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/upload_avatar/bloc/upload_avatar_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class UploadAvatarCubit extends Cubit<UploadAvatarState> {
  UploadAvatarCubit() : super(InitialUploadAvataState());

  // ignore: non_constant_identifier_names
  Future<void> UploadAvatar(File imageAvatar) async {
    emit(LoadingUploadAvataState());
    String accessToken = HiveStorage().token;
    String idUser = HiveStorage().idUser;

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/upload-avatar/$idUser";

      dio.options.headers["Authorization"] = "Bearer $accessToken";

      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(
          imageAvatar.path,
          filename: imageAvatar.path.split("/").last,
          contentType: MediaType("image", "jpg"),
        ),
      });

      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        emit(UploadAvatarSuccessState("UploadAvatar success."));
      } else {
        emit(ErrorUploadAvataState(
            "UploadAvatar failed. ${response.data['message']}"));
      }
    } catch (e) {
      emit(ErrorUploadAvataState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialUploadAvataState());
  }
}
