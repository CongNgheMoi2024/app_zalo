import 'package:app_zalo/constants/index.dart';
import 'package:app_zalo/widget/show_message_by_type/bloc/download_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileView extends StatefulWidget {
  final String url;
  const FileView({super.key, required this.url});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {
    String filename = widget.url.substring(widget.url.length - 20);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            context.read<DownloadCubit>().downloadFileAndOpen(widget.url);
            //OpenFile.open("/data/user/0/com.example.app_zalo/cache/57d0c712-ddf8-4c4e-a339-b3e5f76f77f7/Nâng cao hiệu suất làm việc với ChatGPT.pdf");
            print("Tapped down file");
          },
          child: const Icon(
            Icons.download,
            size: 20,
          ),
        ),
        BlocBuilder<DownloadCubit,DownloadState>(builder:(context,state){
          if(state == DownloadState.initial ){
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Text(
                  filename,
                  softWrap: true,
                ));
          }else if(state == DownloadState.loading){
            return const Center(child: CircularProgressIndicator());
          }else
          if(state == DownloadState.success){
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Text(
                  filename,
                  softWrap: true,
                ));
          }
          else return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Text(
                filename,
                softWrap: true,
              ));

        })
      ],
    );
  }
}

