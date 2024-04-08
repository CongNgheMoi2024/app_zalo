abstract class GetFriendsState {}

class InitialGetFriendsState extends GetFriendsState {}

class LoadingGetFriendsPhoneBookState extends GetFriendsState {}

class ErrorGetFriendsPhoneBookState extends GetFriendsState {
  final String error;
  ErrorGetFriendsPhoneBookState(this.error);
}

class GetFriendsPhoneBookSuccessState extends GetFriendsState {
  dynamic data;
  GetFriendsPhoneBookSuccessState(this.data);
}
