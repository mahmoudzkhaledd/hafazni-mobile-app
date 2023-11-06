import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../Blocs/cubit/view_coupons_cubit.dart';
import 'ChooseDialoge.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key, required this.code, this.loading});
  final PromoCode code;
  final bool? loading;
  @override
  Widget build(BuildContext context) {
    const Color textColor = Color.fromRGBO(52, 45, 15, 1);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // gradient: const LinearGradient(
            //   colors: [
            //     // Color.fromRGBO(248, 238, 51, 1),
            //     //  Color.fromRGBO(225, 66, 62, 1),

            //     //  Color.fromRGBO(74, 192, 250, 1),
            //     //  Color.fromRGBO(56, 81, 226, 1),

            //     Color.fromRGBO(240, 147, 111, 1),
            //     Color.fromRGBO(187, 81, 117, 1),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            color: loading == true
                ? Colors.black.withOpacity(0.1)
                : const Color.fromRGBO(248, 217, 30, 1),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: loading == true ? 150 : null,
          child: loading == true
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const CustomImage(
                    //   //'coupon.png',
                    //   'couponSingle.png',
                    //   width: 70,
                    // ),
                    GestureDetector(
                      onTap: () {
                        
                        Get.dialog(
                          ChooseDialoge(
                            promo: code,
                            onEdit: context.read<ViewCouponsCubit>().onEndEdit,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AppText(
                              code.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FontFamily.bold,
                                color: textColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomContainer(
                            verticalPadding: 3,
                            horizontalPadding: 20,
                            borderRadius: 10,
                            backColor: Colors.grey.shade300,
                            child: AppText(
                              code.valid ? "صالح" : "متوقف",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: FontFamily.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              AppText(
                                "خصم",
                                style: TextStyle(
                                  fontFamily: FontFamily.bold,
                                  color: textColor,
                                  fontSize: 16,
                                ),
                              ),
                              AppText(
                                "${code.discount.toStringAsFixed(2)} ${code.percentage ? "%" : "\$"}",
                                style: TextStyle(
                                  fontFamily: FontFamily.black,
                                  color: textColor,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const DottedLine(
                      lineThickness: 1,
                      dashColor: textColor,
                    ),
                    const SizedBox(height: 10),
                    Tooltip(
                      message: "تم نسخ الكود",
                      textStyle: TextStyle(
                        fontFamily: FontFamily.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      onTriggered: () async {
                        await Clipboard.setData(ClipboardData(text: code.code));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            "كود الخصم (إضغط مطولا للنسخ)",
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: textColor,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              code.code.length,
                              (index) => CustomContainer(
                                verticalPadding: 2,
                                //horizontalPadding: 5,
                                width: (Helper.size(context).width - 120) /
                                    code.code.length,
                                borderRadius: 5,
                                backColor:
                                    const Color.fromRGBO(249, 235, 32, 1),
                                child: AppText(
                                  code.code[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FontFamily.black,
                                    color: textColor,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
        const Positioned(
          right: -10,
          top: -10,
          bottom: 0,
          child: Icon(
            FontAwesomeIcons.solidCircle,
            color: Colors.white,
            size: 25,
          ),
        ),
        const Positioned(
          left: -10,
          top: -10,
          bottom: 0,
          child: Icon(
            FontAwesomeIcons.solidCircle,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}
