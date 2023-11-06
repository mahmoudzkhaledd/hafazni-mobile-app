import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import 'ChargeDialogeCtrl.dart';

class ChargeDialoge extends GetView<ChargeDialogeCtrl> {
  ChargeDialoge({
    super.key,
    required String walletId,
  }) {
    Get.put(ChargeDialogeCtrl(walletId));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: GetBuilder<ChargeDialogeCtrl>(
        builder: (ctrl) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'اكتب المبلغ المراد شحنه',
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextBox(
              isDecimal: true,
              hintText: 'المبلغ',
              errorText: ctrl.err,
              textAlign: TextAlign.center,
              onChanged: (e) => controller.chargePrice = double.tryParse(e),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "شحن",
              icon: ctrl.loading
                  ? const SizedBox.square(
                      dimension: 23,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
              onTap: ctrl.charge,
            ),
          ],
        ),
      ),
    );
  }
}
