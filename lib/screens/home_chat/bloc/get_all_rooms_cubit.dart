import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsUser {
  final String idRoom;
  final UserRecipient userRecipient;
  final LastMessage lastMessage;
  final bool isGroup;
  final String groupName;
  List<String>? members = [];
  String? adminId;

  RoomsUser({
    required this.idRoom,
    required this.userRecipient,
    required this.lastMessage,
    required this.isGroup,
    required this.groupName,
    this.members,
    this.adminId,
  });
  factory RoomsUser.fromJson(Map<String, dynamic> json) {
    return RoomsUser(
        idRoom: json['id'],
        userRecipient: json['userRecipient'] != null
            ? UserRecipient.fromJson(json['userRecipient'])
            : UserRecipient(
                idRecipient: "",
                name: "",
                avatar: "",
                imageCover: "",
                sex: false,
                onlineStatus: false),
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(json['lastMessage'])
            : LastMessage(
                idMessage: "",
                idSender: "",
                idRecipient: "",
                content: "",
                type: "",
                timestamp: DateTime.now().toString(),
                status: ""),
        isGroup: json['group'] ?? false,
        groupName: json['groupName'] ?? "",
        members: json['members'] != null
            ? (json['members'] as List).map((e) => e.toString()).toList()
            : [],
        adminId: json['adminId'] ?? "");
  }
}

class UserRecipient {
  final String idRecipient;
  final String name;
  final String avatar;
  final String imageCover;
  final bool sex;
  final bool onlineStatus;

  UserRecipient({
    required this.idRecipient,
    required this.name,
    required this.avatar,
    required this.imageCover,
    required this.sex,
    required this.onlineStatus,
  });

  factory UserRecipient.fromJson(Map<String, dynamic> json) {
    return UserRecipient(
      idRecipient: json['id'] ?? "",
      name: json['name'] ?? "",
      avatar: json['avatar'] ?? "",
      imageCover: json['imageCover'] ?? "",
      sex: json['sex'] ?? true,
      onlineStatus: json['onlineStatus'] ?? false,
    );
  }
}

class LastMessage {
  final String idMessage;
  final String idSender;
  final String idRecipient;
  final String content;
  final String type;
  final String timestamp;
  final String status;

  LastMessage({
    required this.idMessage,
    required this.idSender,
    required this.idRecipient,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.status,
  });
  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      idMessage: json['id'] ?? "",
      idSender: json['senderId'] ?? "",
      idRecipient: json['recipientId'] ?? "",
      content: json['content'] ?? "",
      type: json['type'] ?? "",
      timestamp: json['timestamp'] ?? "",
      status: json['status'] ?? "",
    );
  }
}

class GetAllRoomCubit extends Cubit<GetAllRoomState> {
  GetAllRoomCubit() : super(InitialGetAllRoomState());

  Future<void> getAllRoomsUser() async {
    String accessToken = HiveStorage().token;
    String idUser = HiveStorage().idUser;
    emit(LoadingGetAllRoomState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/rooms/user/$idUser";

      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        emit(GetAllRoomSuccessState(
          (response.data["data"] as List)
              .map((e) => RoomsUser.fromJson(e))
              .toList(),
        ));
      } else {
        emit(ErrorGetAllRoomState("Error GET ALL ROOMS USER"));
      }
    } catch (e) {
      print("Loiii iii ${e.toString()}");
      emit(ErrorGetAllRoomState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialGetAllRoomState());
  }
}
