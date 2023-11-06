import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../Ctrls/StartPlanCtrl.dart';

class StartPlanDialoge extends GetView<StartPlanCtrl> {
  StartPlanDialoge({
    super.key,
    required Order order,
  }) {
    Get.put(StartPlanCtrl(order));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            'بدء الدورة',
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            width: 1000,
            height: 20,
          ),
          CustomContainer(
            verticalPadding: 20,
            horizontalPadding: 10,
            borderRadius: 12,
            backColor: Colors.black.withOpacity(0.14),
            child: Helper.buildInfo(
              Icons.monetization_on,
              'السعر النهائي',
              controller.order.getFinalPrice.toStringAsFixed(2),
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<StartPlanCtrl>(
            builder: (ctrl) => CustomButton(
              text: 'الدفع',
              icon: !ctrl.loading
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
              verticalPadding: 10,
              onTap: controller.pay,
            ),
          ),
        ],
      ),
    );
  }
}
