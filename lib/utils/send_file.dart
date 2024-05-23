import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/env.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SendFile {
  Future<List<dynamic>> sendFile(
      String senderId,
      String recipientId,
      String chatId,
      List<File> files,
      bool isGroup,
      BuildContext context) async {
    print(
        "Grouppp is $isGroup, chatId is $chatId, recipientId is $recipientId, files is $files, isGroup is $isGroup");
    String token = HiveStorage().token;
    print("Người gửi $senderId, người nhận $recipientId, chatId $chatId");
    try {
      Dio dio = Dio();
      String apiUrl;

      isGroup
          ? apiUrl = "${Env.url}/api/v1/send-file-message-group"
          : apiUrl = "${Env.url}/api/v1/send-file-message";

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
        print("Gửi file thành công ${response.data}");
        List<dynamic> data = response.data["data"];
        return data;
      } else {
        print("Gửi file thất bại ${response.statusCode}");
        return [];
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 413) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Thông báo", style: text18.semiBold.primary),
                  content: Text("File quá lớn, vui lòng chọn file nhỏ hơn 1MB",
                      style: text18.regular.primary),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
        return [];
      }
      print("Gửi file thất bại 222 ${error.response!.statusCode}");
      return [];
    }
  }
}
