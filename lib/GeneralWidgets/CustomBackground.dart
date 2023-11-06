import 'package:flutter/material.dart';

import 'Image.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
    required this.child,
    this.imgWidth,
    this.verticalSpace,
    this.horizontalSpace,
    this.opacity,
  });
  final Widget child;
  final double? imgWidth;
  final double? verticalSpace;
  final double? horizontalSpace;
  final double? opacity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: verticalSpace ?? -170,
          left: horizontalSpace ?? -80,
          child: CustomImage(
            'pattern.png',
            width: imgWidth ?? 350,
            opacity: opacity,
          ),
        ),
        Positioned(
          bottom: verticalSpace ?? -150,
          right: horizontalSpace ?? -150,
          child: CustomImage(
            'pattern.png',
            width: imgWidth ?? 350,
            opacity: opacity,
          ),
        ),
        child,
      ],
    );
  }
}
