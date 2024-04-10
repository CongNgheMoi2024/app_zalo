abstract class ForwardMessageState {}

class InitialForwardMessageState extends ForwardMessageState {}

class LoadingForwardMessageState extends ForwardMessageState {}

class ErrorForwardMessageState extends ForwardMessageState {
  final String error;

  ErrorForwardMessageState(this.error);
}

class ForwardSuccessState extends ForwardMessageState {
  ForwardSuccessState();
}
