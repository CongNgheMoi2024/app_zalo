abstract class AddFriendState {}

class InitialAddFriendState extends AddFriendState {}

class LoadingAddFriendState extends AddFriendState {}

class ErrorAddFriendState extends AddFriendState {
  final String error;

  ErrorAddFriendState(this.error);
}

class AddFriendSuccessState extends AddFriendState {
  AddFriendSuccessState();
}
