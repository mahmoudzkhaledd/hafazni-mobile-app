import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:intl/intl.dart';
import 'Widgets/CouponDataHeader.dart';
import 'Widgets/CouponDetailsWdget.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key, required this.promoCode});
  final PromoCode promoCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("كوبون خصم"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CouponDataHeader(
                promoCode: promoCode,
              ),
              const SizedBox(height: 20),
              CouponDetailWidget(
                icon: const Icon(
                  Icons.lock_clock_outlined,
                  color: Colors.blueAccent,
                ),
                title: 'العدد المطلوب',
                subTitle: promoCode.maxUsers != null
                    ? '${(100 * promoCode.users / promoCode.maxUsers!).toStringAsFixed(1)}% من العدد المطلوب'
                    : "لا يوجد",
                data: '${promoCode.maxUsers ?? "لم يتم\nالتحديد"}',
                dataFontSize: 15,
              ),
              CouponDetailWidget(
                icon: const Icon(
                  Icons.date_range_outlined,
                  color: Colors.orange,
                ),
                title: 'تاريخ البدء',
                subTitle: "تاريخ بدء الكوبون",
                data: promoCode.startingDate != null
                    ? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                        .format(promoCode.startingDate!)
                    : "لم يتم\nالتحديد",
                dataFontSize: 15,
              ),
              CouponDetailWidget(
                icon: const Icon(
                  Icons.date_range_outlined,
                  color: Colors.red,
                ),
                title: 'تاريخ الإنتهاء',
                subTitle: "تاريخ إنهاء الكوبون",
                data: promoCode.endingDate != null
                    ? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                        .format(promoCode.endingDate!)
                    : "لم يتم\nالتحديد",
                dataFontSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
