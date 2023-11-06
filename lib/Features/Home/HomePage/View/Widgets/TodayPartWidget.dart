import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';
import 'package:intl/intl.dart';

class TodayPartWidget extends StatelessWidget {
  const TodayPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          const CustomImage(
            'reading.png',
            width: 60,
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              AppText(
                DateFormat(DateFormat.ABBR_MONTH_DAY).format(DateTime.now()),
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: 15,
                ),
              ),
              AppText(
                "اليوم",
                style: TextStyles.headerStyle.copyWith(
                  fontSize: 19,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              AppText(
                "اكتمل ورد اليوم",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              const Icon(Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }
}
