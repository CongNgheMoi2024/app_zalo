import 'dart:io';

import 'package:app_zalo/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Widget getWidgetByType(
    String nameReply, String type, String fileName, String content) {
  switch (type.toUpperCase()) {
    case "FILE":
      return Row(
        children: [
          SizedBox(
            width: 50.sp,
            height: 50.sp,
            child: Icon(
              Icons.file_present,
              size: 50.sp,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  nameReply,
                  style: text14.black.bold,
                ),
                Text(
                  "[$type]  $fileName",
                  style: text12.black.copyWith(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      );
    case "IMAGE":
      return Container(
        padding: EdgeInsets.only(bottom: 5.sp, left: 5.sp),
        margin: EdgeInsets.only(bottom: 5.sp),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: primaryColor.withOpacity(0.5), width: 3.sp))),
        child: Row(
          children: [
            SizedBox(
                width: 50.sp,
                height: 50.sp,
                child: Image.network(
                  content,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Column(
                children: [
                  Text(
                    nameReply,
                    style: text14.black.bold,
                  ),
                  Text(
                    "[$type]  $fileName",
                    style: text12.black.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            )
          ],
        ),
      );
    case "VIDEO":
      return Container(
        padding: EdgeInsets.only(bottom: 5.sp, left: 5.sp),
        margin: EdgeInsets.only(bottom: 5.sp),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: primaryColor.withOpacity(0.5), width: 3.sp))),
        child: Row(
          children: [
            SizedBox(
                width: 50.sp, height: 50.sp, child: Image.asset(Png.icVideo)),
            Expanded(
              child: Column(
                children: [
                  Text(
                    nameReply,
                    style: text14.black.bold,
                  ),
                  Text(
                    "[$type]  $fileName",
                    style: text12.black.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
        ),
      );
    case "AUDIO":
      return Container(
        padding: EdgeInsets.only(bottom: 5.sp, left: 5.sp),
        margin: EdgeInsets.only(bottom: 5.sp),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: primaryColor.withOpacity(0.5), width: 3.sp))),
        child: Row(
          children: [
            SizedBox(
                width: 50.sp, height: 50.sp, child: Image.asset(Png.iconAudio)),
            Expanded(
              child: Column(
                children: [
                  Text(
                    nameReply,
                    style: text14.black.bold,
                  ),
                  Text(
                    "[$type]  $fileName",
                    style: text12.black.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            )
          ],
        ),
      );
    default:
      return Container(
        padding: EdgeInsets.only(bottom: 5.sp, left: 5.sp),
        margin: EdgeInsets.only(bottom: 5.sp),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: primaryColor.withOpacity(0.5), width: 3.sp))),
        child: Column(
          children: [
            Text(
              nameReply,
              style: text14.black.bold,
            ),
            Text(
              content,
              style: text14.black.copyWith(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      );
  }
}
