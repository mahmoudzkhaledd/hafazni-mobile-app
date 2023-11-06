import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class CouponDetailWidget extends StatelessWidget {
  const CouponDetailWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.data,
    this.dataFontSize,
  });
  final String title;
  final String subTitle;
  final Widget icon;
  final String data;
  final double? dataFontSize;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: 10,
      verticalPadding: 15,
      horizontalPadding: 20,
      marginBottom: 20,
      backColor: const Color.fromRGBO(229, 229, 231, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: icon,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title,
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        color: Colors.black,
                      ),
                    ),
                    AppText(
                      subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontFamily.regular,
                        color: Colors.black.withOpacity(0.3),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 25),
          AppText(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.black,
              color: Colors.black,
              fontSize: dataFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
