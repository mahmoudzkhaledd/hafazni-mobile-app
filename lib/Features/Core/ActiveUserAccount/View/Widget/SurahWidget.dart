import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafazni/Models/Surah.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({
    super.key,
    required this.surah, required this.backColor,
  });
  final Surah? surah;
  final Color backColor;
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle('اسم السورة', surah == null ? "لا يوجد" : surah!.name),
              buildTitle('ترتيبها',
                  surah == null ? "لا يوجد" : surah!.number.toString()),
              buildTitle('عدد اياتها',
                  surah == null ? "لا يوجد" : surah!.ayahNumber.toString()),
              buildTitle(
                'نوعها',
                surah == null
                    ? "لا يوجد"
                    : surah!.makkah
                        ? "سورة مكية"
                        : "سورة مدنية",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
