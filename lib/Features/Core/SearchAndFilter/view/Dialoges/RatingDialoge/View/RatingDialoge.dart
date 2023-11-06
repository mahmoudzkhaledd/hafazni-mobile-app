import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';

import '../Controller/RatingDialogeController.dart';

class RatingDialoge extends GetView<RatingDialogeController> {
  const RatingDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: FontFamily.bold,
      fontSize: 15,
    );
    return AlertDialog(
      title: AppText(
        'اختر اعلى تقييم',
        style: TextStyle(
          fontFamily: FontFamily.bold,
        ),
      ),
      backgroundColor: Colors.white,
      content: Container(
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(237, 237, 237, 1),
        ),
        padding: const EdgeInsets.all(10),
        child: GetBuilder<RatingDialogeController>(
          builder: (ctrl) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    'أعلي تقييم سيظهر لك',
                    style: style,
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.green,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => ctrl.changeRating(5),
                    icon: const Icon(Icons.restore),
                  )
                ],
              ),
              Slider(
                value: ctrl.rating,
                onChanged: ctrl.changeRating,
                min: 0,
                max: 5,
                divisions: 50,
              ),
              Center(
                child: AppText(
                  ctrl.rating.toStringAsFixed(1),
                  style: TextStyles.headerStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actions: [
        CustomButton(
          text: 'تم',
          verticalPadding: 5,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          onTap: controller.done,
        ),
      ],
    );
  }
}
