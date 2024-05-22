import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BackgroundImage extends StatelessWidget {
  final String backgroundImagePath;
  const BackgroundImage({super.key, required this.backgroundImagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetImage(backgroundImagePath),
          fit: BoxFit.fill,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeOutDuration: const Duration(milliseconds: 100),
          height: MediaQuery.of(context).size.height,
          filterQuality: FilterQuality.high,
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }
}
