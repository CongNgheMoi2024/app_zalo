import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/show_message_by_type/bloc/download_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileView extends StatefulWidget {
  final String url;
  final String fileName;
  const FileView({super.key, required this.url, required this.fileName});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            context.read<DownloadCubit>().downloadFileAndOpen(widget.url);
          },
          child: const Icon(
            Icons.download,
            size: 20,
          ),
        ),
        Expanded(
          child: BlocBuilder<DownloadCubit,DownloadState>(builder:(context,state){
            if(state == DownloadState.initial ){
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text(
                    widget.fileName,
                    softWrap: true,
                  ));
            }else if(state == DownloadState.loading){
              return const Center(child: CircularProgressIndicator());
            }else
            if(state == DownloadState.success){
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text(
                     widget.fileName,
                    softWrap: true,
                  ));
            }
            else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Text(
                  widget.fileName,
                  softWrap: true,
                ));
            }
        
          }),
        )
      ],
    );
  }
}

