import 'package:app_zalo/screens/home_chat/bloc/get_all_rooms_cubit.dart';

abstract class GetAllRoomState {}

class InitialGetAllRoomState extends GetAllRoomState {}

class LoadingGetAllRoomState extends GetAllRoomState {}

class ErrorGetAllRoomState extends GetAllRoomState {
  final String error;

  ErrorGetAllRoomState(this.error);
}

class GetAllRoomSuccessState extends GetAllRoomState {
  final List<RoomsUser> data;
  GetAllRoomSuccessState(this.data);
}
