import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../CouponPage/View/CouponPage.dart';

class ChooseDialoge extends StatelessWidget {
  const ChooseDialoge({super.key, required this.promo, required this.onEdit});
  final PromoCode promo;
  final Function(PromoCode) onEdit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.black,
        fontSize: 20,
        color: Colors.black,
      ),
      title: AppText(
        promo.name,
        style: TextStyle(
          fontFamily: FontFamily.bold,
          fontSize: 17,
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            text: 'تعديل',
            backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
            textColor: Colors.white,
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onTap: () => onEdit(promo),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'بيانات الكوبون',
            icon: const Icon(
              Icons.data_saver_off,
              color: Colors.white,
            ),
            onTap: () {
              Get.off(
                () => CouponPage(
                  promoCode: promo,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
