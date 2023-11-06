import 'package:flutter/material.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomProgressBar.dart';
import '../../../../../GeneralWidgets/Image.dart';
import '../../../../../Shared/SharedTextStyles.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key, required this.progress});
  final double progress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'لقد حققت ${(progress * 100).toStringAsFixed(0)}% من هدفك, استمر ...',
                style: TextStyles.headerStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              CustomProgressBar(
                percentage: progress,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const CustomImage(
          'laurel.png',
          width: 47,
        ),
      ],
    );
  }
}
