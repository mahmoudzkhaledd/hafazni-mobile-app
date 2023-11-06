import 'package:flutter/material.dart';

import '../Shared/Fonts/FontModel.dart';
import 'AppText.dart';
import 'CustomContainer.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget(
      {super.key,
      this.backColor,
      this.iconColor,
      this.width,
      this.icon,
      required this.description,
      required this.title});
  final Color? backColor;
  final Color? iconColor;
  final double? width;
  final IconData? icon;
  final String description;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backColor: backColor,
      borderRadius: 10,
      width: width,
      verticalPadding: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Icon(
                icon!,
                color: iconColor,
              ),
            ),
          const SizedBox(height: 20),
          AppText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: 15,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          AppText(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.extraBold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
