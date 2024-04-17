abstract class AddMemberState {}

class InitialAddMemberState extends AddMemberState {}

class LoadingAddMemberState extends AddMemberState {}

class ErrorAddMemberState extends AddMemberState {
  final String error;

  ErrorAddMemberState(this.error);
}

class AddMemberSuccessState extends AddMemberState {
  AddMemberSuccessState();
}
