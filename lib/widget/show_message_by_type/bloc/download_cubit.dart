import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

enum DownloadState { initial, loading, success, error }

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState.initial);
  Future<void> downloadFileAndOpen(String url) async {
    emit(DownloadState.loading);
    try {
      // Khởi tạo Dio
      Dio dio = Dio();

      // Lấy đường dẫn thư mục tạm thời
      final directory = await getTemporaryDirectory();

      // Lấy tên tệp từ URL
      final fileName = url.split('/').last;
      // Đường dẫn của tệp trong thư mục tạm thời
      final filePath = '${directory.path}/$fileName';

      // Tải tệp xuống và lưu vào filePath
      Response response = await dio.download(
        url,
        filePath,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        emit(DownloadState.success);
        OpenFile.open(filePath);
      } else {
        emit(DownloadState.error);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void resetState() {
    emit(DownloadState.initial);
  }
}
