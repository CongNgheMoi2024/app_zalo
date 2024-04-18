import 'package:app_zalo/screens/member_group/bloc/get_members_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../env.dart';
import '../../../storages/hive_storage.dart';
import '../../member_group/bloc/manage_member.dart';
import 'leave_group_state.dart';

class LeaveGroupCubit extends Cubit<LeaveGroupState>{
  LeaveGroupCubit():super(LeaveGroupInitial());
  Future<void> leaveGroup(String idGroup)async {
    final accToken = HiveStorage().token; 
    emit(LeaveGroupLoading());
    try {
    // Tạo URL API
    String apiUrl = "${Env.url}/api/v1/rooms/$idGroup/leave";

    // Cấu hình Dio
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $accToken';
    dio.options.validateStatus = (status) => status! >= 200 && status < 300 || status == 400;

    // Thực hiện yêu cầu HTTP PUT
    Response response = await dio.put(apiUrl);

    // In phản hồi để gỡ rối (có thể loại bỏ trong môi trường sản xuất)
    print("responseeee====" + response.data.toString());

    // Kiểm tra mã trạng thái của phản hồi
    if (response.statusCode == 200) {
        emit(LeaveGroupSuccess());
    } else if (response.statusCode == 400 && response.data['error'] == "Admin can't leave group") {
        // Xử lý trường hợp đặc biệt
        emit(LeaveGroupFailure(error: "Không thể rời nhóm khi đang là nhóm trưởng"));
    } else if(response.statusCode==400 && response.data['error']== "Group must have at least 3 members"){
      emit(LeaveGroupFailure(error: "Không thể rời nhóm khi nhóm chỉ còn 3 thành viên"));
    }else {
        // Xử lý các mã trạng thái 400 khác
        emit(LeaveGroupFailure(error: "Đã xảy ra lỗi trong yêu cầu, vui lòng thử lại sau."));
    }

} catch (e) {
    // Xử lý các ngoại lệ
    if (e is DioException) {
        print('Lỗi DioException: ${e.message}');
    } else {
        print('Lỗi khác: ${e.toString()}');
    }
    emit(LeaveGroupFailure(error: "Đã xảy ra lỗi, vui lòng thử lại sau"));
}
}
  void resetState(){
    emit(LeaveGroupInitial());
  }
}