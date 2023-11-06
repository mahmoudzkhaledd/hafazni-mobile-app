import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:image_picker/image_picker.dart';

class CustomUserImage extends StatelessWidget {
  const CustomUserImage({
    super.key,
    required this.url,
    this.radius = 27,
    this.verified,
    this.file,
  });
  final String url;
  final XFile? file;
  final double radius;
  final bool? verified;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: file != null
              ? FileImage(File(file!.path))
              : url.isNotEmpty
                  ? Helper.loadImageProvider(url, 'user.png')
                  : const AssetImage(
                      'assets/images/user.png',
                    ),
        ),
        if (verified == true)
          Positioned(
            right: 0,
            bottom: -5,
            child: CustomImage(
              'verified.png',
              width: 0.8 * radius,
            ),
          ),
      ],
    );
  }
}
