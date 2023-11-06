import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/Shared/AppColors.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../../../GeneralWidgets/CustomButton.dart';
import '../../../../../Shared/SharedTextStyles.dart';

class AccountConditionsWidget extends StatelessWidget {
  const AccountConditionsWidget({
    super.key,
    required this.type,
    required this.onActive,
  });
  final AccountTypeDescription type;
  final Function() onActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'شروط تفعيل  ${type.title}',
          style: TextStyles.headerStyle.copyWith(
            fontSize: 18,
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: type.conditions
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  e.title,
                                  style: TextStyle(
                                    fontFamily: FontFamily.bold,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                AppText(
                                  e.content,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'خروج',
                onTap: () {
                  Get.back();
                },
                verticalPadding: 5,
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomButton(
                text: "تفعيل",
                onTap: () {
                  Get.back();
                  onActive();
                },
                verticalPadding: 5,
                textStyle: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
