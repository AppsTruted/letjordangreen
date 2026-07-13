import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImageView extends StatelessWidget {
  final String? imageUrl;
  final Function? function;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final Color? color;
  final Widget? placeholder;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final int? memCacheHeight;
  final int? memCacheWidth;

  const CustomCachedNetworkImageView({
    super.key,
    this.imageUrl,
    this.function,
    this.height,
    this.width,
    this.color,
    this.boxFit,
    this.placeholder,
    this.fadeInDuration = Duration.zero,
    this.fadeOutDuration = Duration.zero,
    this.memCacheHeight,
    this.memCacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder ??
          Center(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Icon(Icons.restaurant, size: 20,color: Colors.grey.withOpacity(.3)),
            ),
          );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: boxFit,
      color: color,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      height: height,
      memCacheWidth: memCacheWidth ?? 950,
      memCacheHeight: memCacheHeight ?? 950,
      width: width,
      filterQuality: FilterQuality.low,
      placeholder: (context, url) => placeholder ??
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height ?? 60,
              width: width,
              color: Colors.grey[300],
            ),
          ),
      errorWidget: (context, imageUrl, error) => placeholder ??
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: height ?? 60,
              color: Colors.grey.withOpacity(.4),
            ),
          ),
    );
  }
}
