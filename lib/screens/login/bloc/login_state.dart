abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState(this.error);
}

class LoginenticatedState extends LoginState {
  final String refreshToken;
  final String phoneNumber;
  LoginenticatedState(this.refreshToken, this.phoneNumber);
}
