abstract class DeleteRoomState {}

class InitialDeleteRoomState extends DeleteRoomState {}

class LoadingDeleteRoomState extends DeleteRoomState {}

class ErrorDeleteRoomState extends DeleteRoomState {
  final String error;

  ErrorDeleteRoomState(this.error);
}

class DeleteRoomSuccessState extends DeleteRoomState {
  DeleteRoomSuccessState();
}
