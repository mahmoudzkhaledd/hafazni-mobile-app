import 'package:flutter/material.dart';
import 'package:hafazni/Models/Surah.dart';

import '../../../../../Shared/Fonts/FontModel.dart';

class TimingWidget extends StatelessWidget {
  const TimingWidget({super.key, this.first, this.second, this.errorColor, this.successColor});
  final Surah? first;
  final Surah? second;
  final Color? errorColor;
  final Color? successColor;
  Widget buildTitle(String title, String content) => RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "$title: ",
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: 15,
            ),
          ),
        ]),
      );
  @override
  Widget build(BuildContext context) {
    int diff = (second != null && first != null)
        ? (second!.number - first!.number)
        : -1;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: (diff == -1 || diff <= 0)
            ? (errorColor ?? successColor)
            : successColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            diff > 0 ? Icons.check : Icons.close,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle(
                'فرق السور',
                diff >= 0 ? "$diff سورة" : "غير محددة",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
