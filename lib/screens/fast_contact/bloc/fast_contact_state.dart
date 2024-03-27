abstract class FastContactState {}

class InitialFastContactState extends FastContactState {}

class LoadingFastContactState extends FastContactState {}

class ErrorFastContactState extends FastContactState {
  final String error;
  ErrorFastContactState(this.error);
}

class FastContactFriendsSuccessdState extends FastContactState {
  dynamic data;
  FastContactFriendsSuccessdState(this.data);
}
