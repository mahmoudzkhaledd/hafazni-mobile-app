import 'package:flutter/material.dart';
import 'package:hafazni/Models/PromoCode.dart';

import 'PromoCodeWidget.dart';

class CouponsLoadingWidget extends StatelessWidget {
  const CouponsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 6,
      itemBuilder: (context, index) => CouponWidget(
        code: PromoCode(),
        loading: true,
      ),
    );
  }
}
