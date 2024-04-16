abstract class CreateGroupState {}

class InitialCreateGroupState extends CreateGroupState {}

class LoadingCreateGroupState extends CreateGroupState {}

class ErrorCreateGroupState extends CreateGroupState {
  final String error;

  ErrorCreateGroupState(this.error);
}

class CreateGroupSuccessdState extends CreateGroupState {
  CreateGroupSuccessdState();
}
