abstract class AsyncPhoneBookState {}

class InitialAsyncPhoneBookState extends AsyncPhoneBookState {}

class LoadingAsyncPhoneBookState extends AsyncPhoneBookState {}

class ErrorAsyncPhoneBookState extends AsyncPhoneBookState {
  final String error;

  ErrorAsyncPhoneBookState(this.error);
}

class AsyncSuccessState extends AsyncPhoneBookState {
  final String message;
  AsyncSuccessState(this.message);
}
