abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {
  final int statusCode;
  final String token;

  SuccessRegisterState(this.statusCode, this.token);
}

class ErrorRegisterState extends RegisterState {
  final int statusCode;
  final String errorMessage;

  ErrorRegisterState(this.statusCode, this.errorMessage);
}
