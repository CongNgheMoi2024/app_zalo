import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickFile {
  Future<List<File>> pickMultiImage() async {
    final picker = ImagePicker();
    final List<XFile> xfiles = await picker.pickMultiImage(
        maxHeight: 2024, maxWidth: 2024, imageQuality: 90);
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
        maxHeight: 480, maxWidth: 640, imageQuality: 90);
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

  Future<List<File>> pickVideo() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile == null) {
      return [];
    }

    List<File> files = [];
    files.add(File(pickedFile.path));

    return files;
  }

  Future<List<File>> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf'],
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) {
      return [];
    }

    List<File> files = result.paths.map((path) => File(path!)).toList();

    return files;
  }

  Future<List<File>> pickAudioFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) {
      return [];
    }

    List<File> files = result.paths.map((path) => File(path!)).toList();

    return files;
  }
}
