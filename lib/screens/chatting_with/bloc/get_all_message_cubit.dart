import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_state.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageOfList {
  final String idMessage;
  final String idChat;
  final String idSender;
  final String idReceiver;
  final String timestamp;
  final String content;
  final String type;
  final String? status;

  MessageOfList({
    required this.idMessage,
    required this.idChat,
    required this.idSender,
    required this.idReceiver,
    required this.timestamp,
    required this.content,
    required this.type,
    this.status,
  });

  factory MessageOfList.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['timestamp'] ?? "");

    String formattedTimestamp =
        "${dateTime.hour}:${dateTime.minute} ${dateTime.day}/${dateTime.month}";

    return MessageOfList(
      idMessage: json['id'] ?? "",
      idChat: json['chatId'] ?? "",
      idSender: json['senderId'] ?? "",
      idReceiver: json['recipientId'] ?? "",
      timestamp: formattedTimestamp,
      content: json['content'] ?? "",
      type: json['type'] ?? "",
      status: json['status'] ?? "",
    );
  }
}

class GetAllMessageCubit extends Cubit<GetAllMessageState> {
  GetAllMessageCubit() : super(InitialGetAllMessageState());

  // ignore: non_constant_identifier_names
  Future<void> GetAllMessageenticate(String idSender, String idReceiver) async {
    emit(LoadingGetAllMessageState());
    String accToken = HiveStorage().token;

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/messages/$idSender/$idReceiver";

      Response response = await dio.get(apiUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accToken",
          }));
      if (response.statusCode == 200) {
        List<MessageOfList> data = (response.data["data"] as List)
            .map((e) => MessageOfList.fromJson(e))
            .toList();
        emit(GetAllMessageSuccessState(data));
      } else {
        emit(ErrorGetAllMessageState("GetAllMessage failed. "));
      }
    } catch (e) {
      emit(ErrorGetAllMessageState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialGetAllMessageState());
  }
}
