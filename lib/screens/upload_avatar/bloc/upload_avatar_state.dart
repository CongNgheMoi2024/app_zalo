abstract class UploadAvatarState {}

class InitialUploadAvataState extends UploadAvatarState {}

class LoadingUploadAvataState extends UploadAvatarState {}

class ErrorUploadAvataState extends UploadAvatarState {
  final String error;

  ErrorUploadAvataState(this.error);
}

class UploadAvatarSuccessState extends UploadAvatarState {
  final String message;
  UploadAvatarSuccessState(this.message);
}
