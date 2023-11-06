import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/Shared/AppReposetory.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../Controller/ReadingsDialogeController.dart';

class ReadingsDialoge extends GetView<ReadingsController> {
  const ReadingsDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: FontFamily.bold,
      color: Colors.black,
    );
    return AlertDialog(
      title: const AppText('فلترة القراءات'),
      content: Container(
        width: 500,
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(237, 237, 237, 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const AppText('القراءة المناسبة لطلبك'),
                const SizedBox(width: 10),
                const Icon(
                  Icons.record_voice_over_rounded,
                  color: Colors.green,
                ),
                const Spacer(),
                IconButton(
                  onPressed: controller.restore,
                  icon: const Icon(Icons.restore),
                ),
              ],
            ),
            Flexible(
              child: GetBuilder<ReadingsController>(
                builder: (ctrl) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: AppRepository.readings.length,
                  itemBuilder: (ctx, idx) => CheckboxListTile(
                    onChanged: (bool? value) {
                      if (value != null) {
                        ctrl.chooseReading(idx + 1);
                      }
                    },
                    title: AppText(
                      AppRepository.readings[idx],
                      style: style,
                    ),
                    value: ctrl.chosen[idx + 1] ?? false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      actions: [
        CustomButton(
          text: "اختر",
          onTap: controller.done,
          verticalPadding: 5,
        ),
      ],
    );
  }
}
