import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  static Widget networkImage({
    String? url,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    Alignment alignment = Alignment.center,
    LoadingErrorWidgetBuilder? errorWidget,
  }) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: CachedNetworkImage(
        alignment: alignment,
        imageUrl: url ?? '',
        fit: fit ?? BoxFit.cover,
        color: color,
        errorWidget: errorWidget ??
            (context, error, _) {
              return Container();
            },
      ),
    );
  }

  static Widget pngAsset(
    String name, {
    Color? color,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    bool circle = false,
    BoxFit? fit,
  }) {
    return Image.asset(
      name,
      color: color,
      alignment: alignment,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      errorBuilder: (context, error, _) {
        return Container();
      },
    );
  }

  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      name,
      colorFilter: ColorFilter.mode(
        color ?? Colors.transparent,
        BlendMode.modulate,
      ),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget svgUrl(
    String name, {
    Color? color,
    double? width,
    double? height,
    bool circle = false,
    Widget? placeholderWidget,
    EdgeInsets padding = const EdgeInsets.all(6.0),
  }) {
    return Padding(
      padding: padding,
      child: SvgPicture.network(
        name,
        colorFilter: ColorFilter.mode(
          color ?? Colors.transparent,
          BlendMode.modulate,
        ),
        placeholderBuilder: (context) => placeholderWidget ?? Container(),
        width: width,
        height: height,
      ),
    );
  }
}
