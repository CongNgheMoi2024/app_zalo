import 'dart:io';

import 'package:dio/dio.dart';

import '../env.dart';
import '../storages/hive_storage.dart';

class SendFile {
  Future<List<dynamic>> sendFile(
      String senderId, String recipientId, List<File> files) async {
    String token = HiveStorage().token;
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/send-file-message";

      FormData formData = FormData();
      formData.fields.add(MapEntry("senderId", senderId));
      formData.fields.add(MapEntry("recipientId", recipientId));
      for (int i = 0; i < files.length; i++) {
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(
            files[i].path,
            filename: files[i].path.split("/").last,
          ),
        ));
      }
      Response response = await dio.post(
        apiUrl,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token",
        }),
        data: formData,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"];
        return data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
