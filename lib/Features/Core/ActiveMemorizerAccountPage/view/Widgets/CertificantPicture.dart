import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedColors.dart';

class CertificantPicture extends StatelessWidget {
  const CertificantPicture({
    super.key,
    this.fileUrl,
    required this.onTap,
    required this.onTapTop, this.fileName,
  });
  final String? fileUrl;
  final String? fileName;
  final Function() onTap;
  final Function() onTapTop;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            width: double.infinity,
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.image,
                    size: 70,
                    color: fileUrl != null ? AppColors.mainColor : Colors.black,
                  ),
                  const SizedBox(height: 5),
                  AppText(
                    (fileUrl == null) ? "لم يتم اختيار صورة" : "تم اختيار صورة",
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      fontSize: 17,
                    ),
                  ),
                  if (fileUrl != null) const AppText('اضغط هنا لعرض الصورة')
                ],
              ),
            ),
          ),
        ),
        if (fileUrl != null)
          Positioned(
            top: -10,
            left: -10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.red,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.close),
                onPressed: onTapTop,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
