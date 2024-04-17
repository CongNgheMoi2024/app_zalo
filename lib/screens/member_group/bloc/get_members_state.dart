import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';

abstract class GetMembersState{}
class InitialGetMembersState extends GetMembersState{}
class LoadingGetMembersState extends GetMembersState{}
class ErrorGetMembersState extends GetMembersState{
  final String error;
  ErrorGetMembersState(this.error);
}
class 
SuccessGetMembersState extends GetMembersState{
  List<Member> data;
  SuccessGetMembersState(this.data);
}