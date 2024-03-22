abstract class OTPForgotPasswordState {}

class InitialOTPForgotPasswordState extends OTPForgotPasswordState {}

class LoadingOTPForgotPasswordState extends OTPForgotPasswordState {}

class ErrorOTPForgotPasswordState extends OTPForgotPasswordState {
  final String error;

  ErrorOTPForgotPasswordState(this.error);
}

class SuccessOTPForgotState extends OTPForgotPasswordState {
  final String otp;
  SuccessOTPForgotState(this.otp);
}
