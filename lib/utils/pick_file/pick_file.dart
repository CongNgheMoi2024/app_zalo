import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickFile {

  Future<List<File>> pickMultiImage() async {
    final picker = ImagePicker();
    final List<XFile> xfiles = await picker.pickMultiImage(
        maxHeight: 2024,
        maxWidth: 2024,
        imageQuality: 90);
    if (xfiles.isNotEmpty) {
      List<File> files = [];
      for (XFile xFile in xfiles) {
        files.add(File(xFile.path));
      }
      return files;
    } else {
      return [];
    }
  }

  Future<List<File>> pickMultiMedia() async {
    final picker = ImagePicker();
    final List<XFile> xfiles = await picker.pickMultipleMedia(
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 90);
    if (xfiles.isNotEmpty) {
      List<File> files = [];
      for (XFile xFile in xfiles) {
        print(xFile.path);
        files.add(File(xFile.path));
      }
      return files;
    } else {
      return [];
    }
  }
}