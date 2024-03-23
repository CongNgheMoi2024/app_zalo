abstract class InforAccountState {}

class InitialInforAccountState extends InforAccountState {}

class LoadingInforAccountState extends InforAccountState {}

class ErrorInforAccountState extends InforAccountState {
  final String error;

  ErrorInforAccountState(this.error);
}

class InforAccountSuccessState extends InforAccountState {
  final String idUser;
  final String phoneNumber;
  InforAccountSuccessState(this.idUser, this.phoneNumber);
}
