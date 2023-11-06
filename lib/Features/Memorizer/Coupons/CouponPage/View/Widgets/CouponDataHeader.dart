import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/DetailWidget.dart';
import 'package:hafazni/Models/PromoCode.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';

class CouponDataHeader extends StatelessWidget {
  const CouponDataHeader({super.key, required this.promoCode});
  final PromoCode promoCode;

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.black;
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomContainer(
          backColor: const Color.fromRGBO(248, 217, 28, 1),
          borderRadius: 10,
          width: double.infinity,
          verticalPadding: 20,
          horizontalPadding: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AppText(
                      "إسم الكوبون: ${promoCode.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  AppText(
                    "${promoCode.discount} ${promoCode.percentage ? "%" : "\$"}",
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: List.generate(
                  promoCode.code.length,
                  (index) => Expanded(
                    child: CustomContainer(
                      verticalPadding: 4,
                      marginRight: index == 0 ? 0 : 5,
                      borderRadius: 5,
                      backColor: const Color.fromRGBO(249, 235, 32, 1),
                      child: AppText(
                        promoCode.code[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontFamily.black,
                          color: textColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     AppText(
              //       "خصم",
              //       style: TextStyle(
              //         fontFamily: FontFamily.bold,
              //         fontSize: 15,
              //       ),
              //     ),
              //     AppText(
              //       "${promoCode.discount} ${promoCode.percentage ? "%" : "\$"}",
              //       style: TextStyle(
              //         fontFamily: FontFamily.bold,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: DetailWidget(
                icon: Icons.timeline_rounded,
                description: "${promoCode.users} مرة",
                title: 'مرات الإستخدام',
                backColor: const Color.fromRGBO(255, 246, 237, 1),
                iconColor: const Color.fromRGBO(252, 146, 60, 1),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DetailWidget(
                icon: promoCode.valid ? Icons.check : Icons.clear,
                description: promoCode.valid ? "صالح" : "غير صالح",
                title: 'الصلاحية',
                backColor: const Color.fromRGBO(239, 246, 255, 1),
                iconColor: const Color.fromRGBO(59, 130, 246, 1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
