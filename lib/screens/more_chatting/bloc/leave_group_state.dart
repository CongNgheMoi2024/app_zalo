abstract class LeaveGroupState{}
class LeaveGroupInitial extends LeaveGroupState{}
class LeaveGroupLoading extends LeaveGroupState{}
class LeaveGroupSuccess extends LeaveGroupState{}
class LeaveGroupIsAdmin extends LeaveGroupState{}
class LeaveGroupFailure extends LeaveGroupState{
  final String error;
  LeaveGroupFailure({required this.error});
}