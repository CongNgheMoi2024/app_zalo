import 'dart:io';

import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/upload_cover_image/bloc/upload_cover_state.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class UploadCoverCubit extends Cubit<UploadCoverState> {
  UploadCoverCubit() : super(InitialUploadCoverState());

  // ignore: non_constant_identifier_names
  Future<void> uploadCoverImage(File imageCover) async {
    emit(LoadingUploadCoverState());
    String accessToken = HiveStorage().token;
    String idUser = HiveStorage().idUser;
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/upload-image-cover/$idUser";

      dio.options.headers["Authorization"] = "Bearer $accessToken";

      FormData formData = FormData.fromMap({
        "image-cover": await MultipartFile.fromFile(
          imageCover.path,
          filename: imageCover.path.split("/").last,
          contentType: MediaType("image", "jpg"),
        ),
      });

      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        emit(UploadCoverSuccessState());
      } else {
        emit(ErrorUploadCoverState("UploadCover failed. "));
      }
    } catch (e) {
      emit(ErrorUploadCoverState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialUploadCoverState());
  }
}
