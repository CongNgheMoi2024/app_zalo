abstract class VerifyRegisterState {}

class InitialVerifyRegisterState extends VerifyRegisterState {}

class LoadingVerifyRegisterState extends VerifyRegisterState {}

class ErrorVerifyRegisterState extends VerifyRegisterState {
  final String error;

  ErrorVerifyRegisterState(this.error);
}

class VerifyRegisterSuccessState extends VerifyRegisterState {
  String? phoneNumber;
  VerifyRegisterSuccessState(this.phoneNumber);
}
