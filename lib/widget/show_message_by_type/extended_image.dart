import 'package:app_zalo/constants/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ExtendedImageCustom extends StatefulWidget {
  final String url;

  const ExtendedImageCustom({super.key, required this.url});

  @override
  State<ExtendedImageCustom> createState() => _ExtendedImageCustomState();
}

class _ExtendedImageCustomState extends State<ExtendedImageCustom> {
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      // width:,
      // height: ,
      // fit: ,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Image.asset(
              CommonGif.loading,
              fit: BoxFit.fill,
            );
            break;

          ///if you don't want override completed widget
          ///please return null or state.completedWidget
          //return null;
          //return state.completedWidget;
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              // width: 250.sp,
              // height: 150.sp,
            );
            break;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ImageAssets.pngAsset(Png.imgFail),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      "load image failed, click to reload",
                      textAlign: TextAlign.center,
                      style: text18.error,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
        }
      },
    );
  }
}
