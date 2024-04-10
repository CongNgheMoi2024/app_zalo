import 'package:image_picker/image_picker.dart';

class PickFile {

  Future<List<XFile>> pickMultiImage() async {
      final picker = ImagePicker();
      final List<XFile> files = await picker.pickMultiImage(
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 90);
      if(files.isNotEmpty) {
        return files;
      } else {
        return [];
      }
  }
  Future<List<XFile>> pickMultiMedia() async {
    final picker = ImagePicker();
    final List<XFile> files = await picker.pickMultipleMedia(
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 90);
    if(files.isNotEmpty) {
      return files;
    } else {
      return [];
    }
  }
}
