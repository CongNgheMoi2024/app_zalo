abstract class ForgotPasswordState {}

class InitialForgotPasswordState extends ForgotPasswordState {}

class LoadingForgotPasswordState extends ForgotPasswordState {}

class ErrorForgotPasswordState extends ForgotPasswordState {
  final String error;

  ErrorForgotPasswordState(this.error);
}

class ForgotPasswordenticatedState extends ForgotPasswordState {
  final String phoneNumber;
  ForgotPasswordenticatedState(this.phoneNumber);
}
