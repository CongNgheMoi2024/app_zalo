abstract class PhoneOtpRegisState {}

class InitialPhoneOtpRegisState extends PhoneOtpRegisState {}

class LoadingPhoneOtpRegisState extends PhoneOtpRegisState {}

class SuccessPhoneOtpRegisState extends PhoneOtpRegisState {
  final String phoneNumber;

  SuccessPhoneOtpRegisState(this.phoneNumber);
}

class ErrorPhoneOtpRegisState extends PhoneOtpRegisState {
  final String errorMessage;

  ErrorPhoneOtpRegisState(this.errorMessage);
}
