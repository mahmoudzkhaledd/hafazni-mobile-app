import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/Dialoges/SendRequestDialoge/Ctrl/SendPlanRequestCtrl.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/Widgets/PriceWidget.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../../Models/Order.dart';

class SendRequestDialoge extends GetView<SendPlanRequestCtrl> {
  SendRequestDialoge({
    super.key,
    required Plan plan,
    Order? order,
  }) {
    Get.put(SendPlanRequestCtrl(plan,order));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: GetBuilder<SendPlanRequestCtrl>(
          builder: (ctrl) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  "طلب الدورة",
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText('سعر الدورة'),
                    PriceWidget(
                      price: controller.plan.price,
                      afterDiscount: controller.plan.afterDiscount,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (controller.order.promoCode != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText('بعد الكوبون'),
                      PriceWidget(
                        price: controller.order.promoCode!
                            .applyCoupon(controller.plan.price),
                        afterDiscount: null,
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                const AppText("كوبون خصم"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextBox(
                        hintText: "XXXXXXXX",
                        maxLength: 8,
                        letterSpacing: 10,
                        initialValue: controller.order.promoCode == null
                            ? null
                            : controller.order.promoCode!.code,
                        errorText: controller.error,
                        onChanged: (e) => controller.code = e,
                        textAlign: TextAlign.center,
                        englishOnly: true,
                        spaces: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    !ctrl.loadingCoupon
                        ? CustomIconButton(
                            icon: Icons.check,
                            verticalPadding: 10,
                            horizontalPadding: 10,
                            onTap: controller.tryCoupon,
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                  width: 1000,
                ),
                CustomTextBox(
                  onChanged: (e) => controller.order.note = e,
                  hintText: 'اكتب رسالة للمحفظ',
                  maxLines: 4,
                  initialValue: controller.order.note,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'ارسل طلب',
                  onTap: ctrl.sendRequest,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
