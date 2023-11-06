import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';

class LoadingFailsWidget extends StatelessWidget {
  const LoadingFailsWidget({
    super.key,
    required this.title,
    required this.image,
    this.imageWidth,
  });
  final String title;
  final String image;
  final double? imageWidth;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            image,
            width: imageWidth ?? 200,
          ),
          AppText(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
