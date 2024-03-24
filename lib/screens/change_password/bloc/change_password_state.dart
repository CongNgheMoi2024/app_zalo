abstract class ChangePasswordState {}

class InitialChangePasswordState extends ChangePasswordState {}

class LoadingChangePasswordState extends ChangePasswordState {}

class ErrorChangePasswordState extends ChangePasswordState {
  final String error;

  ErrorChangePasswordState(this.error);
}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String message;
  ChangePasswordSuccessState(this.message);
}
