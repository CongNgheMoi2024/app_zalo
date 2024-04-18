import 'dart:io';

import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';

class SendFile {
  Future<List<dynamic>> sendFile(String senderId, String recipientId,
      String chatId, List<File> files, bool isGroup) async {
    print(
        "Grouppp is $isGroup, chatId is $chatId, recipientId is $recipientId, files is $files, isGroup is $isGroup");
    String token = HiveStorage().token;
    try {
      Dio dio = Dio();
      String apiUrl;

      isGroup
          ? apiUrl = "${Env.url}/api/v1/send-file-message-group"
          : apiUrl = "${Env.url}/api/v1/send-file-message";

      print("apiUrl is $apiUrl");
      FormData formData = FormData();
      formData.fields.add(MapEntry("senderId", senderId));
      isGroup == true
          ? formData.fields.add(MapEntry("chatId", chatId))
          : formData.fields.add(MapEntry("recipientId", recipientId));
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
