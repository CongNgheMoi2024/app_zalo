abstract class InforAccountState {}

class InitialInforAccountState extends InforAccountState {}

class LoadingInforAccountState extends InforAccountState {}

class ErrorInforAccountState extends InforAccountState {
  final String error;

  ErrorInforAccountState(this.error);
}

class InforAccountSuccessState extends InforAccountState {
  final Object user;
  final String phone;
  final String avatar;
  final String imageCover;
  InforAccountSuccessState(
    this.user,
    this.phone,
    this.avatar,
    this.imageCover,
  );
}
