import 'package:app_zalo/env.dart';
import 'package:app_zalo/screens/register/bloc/phone_otp_regis_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneOtpRegisCubit extends Cubit<PhoneOtpRegisState> {
  PhoneOtpRegisCubit() : super(InitialPhoneOtpRegisState());

  // ignore: non_constant_identifier_names
  Future<void> phoneOtpRegis(String phoneNumber) async {
    emit(LoadingPhoneOtpRegisState());

    try {
      Dio dio = Dio();
      String apiUrl = "${Env.url}/api/v1/phoneNumber";

      Response response = await dio
          .post(apiUrl, data: {"phoneNo": "+84${phoneNumber.substring(1)}"});
      if (response.statusCode == 200) {
        emit(SuccessPhoneOtpRegisState(phoneNumber));
      } else {
        emit(ErrorPhoneOtpRegisState("PhoneOtpRegis failed."));
      }
    } catch (e) {
      emit(ErrorPhoneOtpRegisState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialPhoneOtpRegisState());
  }
}
