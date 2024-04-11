import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';

class FileView extends StatelessWidget {
  String? url;
  FileView({super.key,required this.url});
  @override
  Widget build(BuildContext context) {
    String filename = url!.split("/").last;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:(){
            print("Tapped down file");
          },
          child:const Icon(Icons.download,size:20,),
        ),
        Padding(
    padding:EdgeInsets.symmetric(horizontal: 10.sp)
            ,child: Text(filename))
      ],
    );
  }
}
