abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {
  SuccessRegisterState();
}

class ErrorRegisterState extends RegisterState {
  final int statusCode;
  final String errorMessage;

  ErrorRegisterState(this.statusCode, this.errorMessage);
}
