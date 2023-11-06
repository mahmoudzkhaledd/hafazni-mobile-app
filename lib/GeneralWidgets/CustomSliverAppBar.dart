import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Shared/Fonts/FontModel.dart';
import 'AppText.dart';
import 'Image.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.image,
    this.height = 250,
    required this.title,
    required this.subTitle,
    this.child,
    this.padding,
    this.titleBoxOpacity,
    this.titleColor,
    this.subTitleColor,
    this.topDistance,
  });
  final String image;
  final double? height;
  final double? padding;
  final String title;
  final String subTitle;
  final double? titleBoxOpacity;
  final double? topDistance;
  final Color? titleColor;
  final Color? subTitleColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: CustomImage(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: topDistance),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(titleBoxOpacity ?? 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: AppText(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        color: titleColor ?? Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  AppText(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      color: subTitleColor ??
                          const Color.fromARGB(255, 218, 218, 218),
                      fontSize: 15,
                    ),
                  ),
                  if (child != null) child!,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
