import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sumra_chat/generated/assets.dart';

class AppFadeInImage extends StatelessWidget {
  const AppFadeInImage(
      {Key? key,
      this.size,
      required this.url,
      this.placeHolder,
      this.fit = BoxFit.cover})
      : super(key: key);
  final double? size;
  final String url;
  final BoxFit fit;
  final String? placeHolder;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: CachedNetworkImageProvider(url),
      fit: fit,
      height: size,
      width: size,
      /*imageErrorBuilder: (context, error, stackTrace) =>
          Image.asset(Assets.imagesTransparentPlaceholder),*/
      placeholder:
          AssetImage(placeHolder ?? Assets.imagesTransparentPlaceholder),
      placeholderErrorBuilder: (context, error, stackTrace) => Container(),
    );
  }
}
