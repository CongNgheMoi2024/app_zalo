abstract class EditProfileState {}

class InitialEditProfileState extends EditProfileState {}

class LoadingEditProfileState extends EditProfileState {}

class ErrorEditProfileState extends EditProfileState {
  final String error;
  ErrorEditProfileState(this.error);
}

class EditProfileSuccessState extends EditProfileState {
  EditProfileSuccessState();
}
