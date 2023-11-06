import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../Ctrls/AddCouponsDialogeCtrl.dart';

class AddCouponsDialoge extends GetView<AddCouponsDialogeCtrl> {
  AddCouponsDialoge({
    super.key,
    required List<PromoCode> codes,
    required double price,
  }) {
    Get.put(AddCouponsDialogeCtrl(codes, price));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "الكوبونات",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 15,
                ),
              ),
              IconButton(
                onPressed: controller.refreshCoupons,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          GetBuilder<AddCouponsDialogeCtrl>(
            builder: (ctrl) {
              if (ctrl.loading || ctrl.fail) {
                return Helper.loadingWidget();
              }
              if (ctrl.promoCodes.isEmpty) {
                return const LoadingFailsWidget(
                  title: 'لا يوجد كوبونات خصم',
                  image: 'empty-box.png',
                  imageWidth: 150,
                );
              }
              return Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ctrl.promoCodes
                        .map((prCode) => CheckboxListTile(
                              title: AppText(prCode.name),
                              value: ctrl.selectedCodes[prCode.id] != null,
                              onChanged: (val) {
                                if (val != null) {
                                  ctrl.selectPrCode(prCode, val);
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            child: CustomButton(
              text: "تم",
              verticalPadding: 5,
              onTap: () {
                final List<PromoCode> codes =
                    controller.selectedCodes.values.toList();
                Get.back<List<PromoCode>>(result: codes);
              },
            ),
          ),
        ],
      ),
    );
  }
}
