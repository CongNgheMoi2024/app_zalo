import 'package:app_zalo/screens/chatting_with/bloc/get_all_message_cubit.dart';
import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';

abstract class GetAllMessageState {}

class InitialGetAllMessageState extends GetAllMessageState {}

class LoadingGetAllMessageState extends GetAllMessageState {}

class ErrorGetAllMessageState extends GetAllMessageState {
  final String error;

  ErrorGetAllMessageState(this.error);
}

class GetAllMessageSuccessState extends GetAllMessageState {
  List<MessageOfList> data;
  List<Member> members;
  GetAllMessageSuccessState(this.data,this.members);
}
