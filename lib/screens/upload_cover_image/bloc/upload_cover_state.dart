abstract class UploadCoverState {}

class InitialUploadCoverState extends UploadCoverState {}

class LoadingUploadCoverState extends UploadCoverState {}

class ErrorUploadCoverState extends UploadCoverState {
  final String error;

  ErrorUploadCoverState(this.error);
}

class UploadCoverSuccessState extends UploadCoverState {
  UploadCoverSuccessState();
}
