import 'package:app_zalo/screens/fast_contact/bloc/fast_contact_cubit.dart';

abstract class FastContactState {}

class InitialFastContactState extends FastContactState {}

class LoadingFastContactState extends FastContactState {}

class ErrorFastContactState extends FastContactState {
  final String error;
  ErrorFastContactState(this.error);
}

class FastContactFriendsSuccessdState extends FastContactState {
  List<FriendsM> data;
  FastContactFriendsSuccessdState(this.data);
}
