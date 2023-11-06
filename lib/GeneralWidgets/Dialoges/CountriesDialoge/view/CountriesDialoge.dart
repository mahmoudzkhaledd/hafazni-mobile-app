import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Models/Country.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../Controller/ContriesController.dart';

class CountryDialoge extends GetView<CountriesController> {
  const CountryDialoge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(
        'تصفح الدول',
        style: TextStyle(
          fontFamily: FontFamily.bold,
        ),
      ),
      actionsPadding: controller.chooseOne ? const EdgeInsets.all(0) : null,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (!controller.chooseOne)
          SizedBox(
            width: 200,
            child: CustomButton(
              text: 'تم',
              verticalPadding: 5,
              icon: const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 22,
              ),
              horizontalPadding: 20,
              backgroundColor: Colors.green,
              onTap: controller.done,
            ),
          ),
      ],
      content: Container(
        constraints: const BoxConstraints(
          maxHeight: 500,
        ),
        width: 550,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextBox(
                    initialValue: controller.search,
                    onChanged: (e) {
                      controller.search = e;
                      controller.getCountries();
                    },
                    hintText: 'ابحث عن دولتك',
                  ),
                ),
                const SizedBox(width: 10),
                CustomIconButton(
                  icon: Icons.clear,
                  backColor: Colors.redAccent,
                  iconColor: Colors.white,
                  onTap: controller.clearChoises,
                  verticalPadding: 10,
                  horizontalPadding: 10,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: GetBuilder<CountriesController>(
                id: 'countriedBuilder',
                builder: (ctrl) {
                  final TextStyle style = TextStyle(
                    fontFamily: FontFamily.bold,
                    color: Colors.black,
                  );
                  if (ctrl.countryList.isEmpty &&
                      ctrl.selectedCountries.isEmpty) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImage(
                          'not-found.png',
                          width: 100,
                        ),
                        AppText("أكتب اسم دولتك في البحث"),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: ctrl.countryList.length,
                    itemBuilder: (ctx, idx) {
                      final e = ctrl.countryList[idx];
                      if (ctrl.chooseOne) {
                        return ListTile(
                          title: DefaultTextStyle(
                            style: const TextStyle(color: Colors.black),
                            child: AppText(
                              e.arabicName,
                              style: style,
                            ),
                          ),
                          onTap: () => Get.back<Country>(result: e),
                        );
                      }
                      return CheckboxListTile(
                        title: DefaultTextStyle(
                          style: const TextStyle(color: Colors.black),
                          child: AppText(
                            e.arabicName,
                            style: style,
                          ),
                        ),
                        onChanged: (bool? value) {
                          if (value != null) {
                            ctrl.onChanged(e.code);
                          }
                        },
                        value: ctrl.selectedCountries[e.code] ?? false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
