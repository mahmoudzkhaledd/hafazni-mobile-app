import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    required this.afterDiscount,
    this.width,
  });
  final double price;
  final double? afterDiscount;
  final double? width;
  @override
  Widget build(BuildContext context) {
    double after = afterDiscount ?? price;
    return CustomContainer(
      verticalPadding: 5,
      horizontalPadding: 9,
      borderRadius: 8,
      width: width,
      backColor: const Color.fromRGBO(250, 250, 250, 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (afterDiscount != null)
            AppText(
              "\$${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontFamily: FontFamily.bold,
                decoration: TextDecoration.lineThrough,
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          const SizedBox(width: 5),
          AppText(
            "\$${after.toStringAsFixed(2)}",
            style: TextStyle(
              fontFamily: FontFamily.black,
              fontSize: 16,
              color: const Color(0xff01aa2c),
            ),
          ),
        ],
      ),
    );
  }
}
