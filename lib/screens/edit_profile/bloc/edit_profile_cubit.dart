import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/edit_profile/bloc/edit_profile_state.dart';
import 'package:app_zalo/storages/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(InitialEditProfileState());

  // ignore: non_constant_identifier_names
  Future<void> editProfile(
      String name, String dateOfBirth, int sex, String phone) async {
    String accessToken = HiveStorage().token;
    emit(LoadingEditProfileState());

    print(
        "  editProfile: name: $name, dateOfBirth: $dateOfBirth, sex: $sex, phone: $phone");
    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/users/update/$phone";

      Response response = await dio.put(apiUrl,
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: {"name": name, "sex": sex, "birthday": dateOfBirth});

      if (response.statusCode == 200) {
        print("Cập nhật thông tin thành công ${response.data}");
        emit(EditProfileSuccessState());
      } else {
        emit(ErrorEditProfileState("EditProfile failed.}"));
      }
    } catch (e) {
      print("Looixiii ${e.toString()}");
      emit(ErrorEditProfileState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialEditProfileState());
  }
}
