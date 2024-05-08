import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_state.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';
import 'package:app_zalo/screens/member_group/bloc/manage_member.dart';
import 'package:app_zalo/storages/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserM {
  final String id;
  final String name;
  final String avatar;
  final String? sex;

  UserM({required this.id, required this.name, required this.avatar, this.sex});

  factory UserM.fromJson(Map<String, dynamic> json) {
    return UserM(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      avatar: json['avatar'] ?? "",
    );
  }
}

class MessageOfList {
  final String idMessage;
  final String idChat;
  final String idSender;
  final String idReceiver;
  final String timestamp;
  final String content;
  final String type;
  final String fileName;
  final String replyTo;
  final String? status;
  final UserM? user;

  MessageOfList({
    required this.idMessage,
    required this.idChat,
    required this.idSender,
    required this.idReceiver,
    required this.timestamp,
    required this.content,
    required this.type,
    required this.fileName,
    required this.replyTo,
    this.status,
    this.user,
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
      fileName: json['fileName'] ?? "",
      replyTo: json['replyTo'] ?? "",
      status: json['status'] ?? "",
      user: json['user'] != null ? UserM.fromJson(json['user']) : null,
    );
  }
}

class GetAllMessageCubit extends Cubit<GetAllMessageState> {
  GetAllMessageCubit() : super(InitialGetAllMessageState());

  // ignore: non_constant_identifier_names
  Future<void> GetAllMessageenticate(
      String idSender, String idReceiver, bool isGroup, String idGroup) async {
    emit(LoadingGetAllMessageState());
    String accToken = HiveStorage().token;

    try {
      Dio dio = Dio();
      String apiUrl = isGroup
          ? "${Env.url}/api/v1/group-messages/$idSender/$idGroup"
          : "${Env.url}/api/v1/messages/$idSender/$idReceiver";

      Response response = await dio.get(apiUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accToken",
          }));
      List<Member> members = await getMembers(idGroup);
      if (response.statusCode == 200) {
        List<MessageOfList> data = (response.data["data"] as List)
            .map((e) => MessageOfList.fromJson(e))
            .toList();
        emit(GetAllMessageSuccessState(data, members));
      } else {
        emit(ErrorGetAllMessageState("GetAllMessage failed. "));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEDDDDEEEEEEEEEE $e");
      emit(ErrorGetAllMessageState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialGetAllMessageState());
  }
}
