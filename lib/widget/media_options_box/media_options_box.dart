import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/utils/pick_file/pick_file.dart';
import 'package:flutter/material.dart';

class MediaOptions extends StatefulWidget {
  final bool visible;
  final void Function(List<File>) onFileSelected;

  const MediaOptions(
      {super.key, required this.visible, required this.onFileSelected});
  @override
  State<MediaOptions> createState() => _MediaOptionsState();
}

class _MediaOptionsState extends State<MediaOptions> {
  final PickFile _pickFile = PickFile();
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.visible,
        child: Container(
          margin: EdgeInsets.only(top: 5.sp),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: grey03.withOpacity(0.5)))),
          height: 200.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  List<File> files = await _pickFile.pickMultiImage();
                  widget.onFileSelected(files);
                },
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      ImageAssets.pngAsset(Png.iconPhoto,
                          width: 60.sp, height: 60.sp),
                      const Text('Hình ảnh'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  List<File> files = await _pickFile.pickAudioFiles();
                  widget.onFileSelected(files);
                },
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      ImageAssets.pngAsset(Png.iconAudio,
                          width: 60.sp, height: 60.sp),
                      const Text('Âm thanh'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  List<File> files = await _pickFile.pickDocument();
                  widget.onFileSelected(files);
                },
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      ImageAssets.pngAsset(Png.iconDocument,
                          width: 60.sp, height: 60.sp),
                      const Text('Tài liệu'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  List<File> files = await _pickFile.pickVideo();
                  widget.onFileSelected(files);
                },
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      Icon(
                        Icons.video_file_outlined,
                        size: 60.sp,
                        color: Colors.blue,
                      ),
                      const Text('Video'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
