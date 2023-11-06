import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomBackground.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class PaymentCards extends StatelessWidget {
  const PaymentCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: CustomContainerWidget(title: 'رصيد حالي', value: 1000)),
        SizedBox(width: 30),
        Expanded(child: CustomContainerWidget(title: 'رصيد معلق', value: 1000)),
      ],
    );
  }
}

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget(
      {super.key, required this.title, required this.value});
  final String title;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff61B879),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      height: 150,
      width: double.infinity,
      child: CustomBackground(
        imgWidth: 150,
        verticalSpace: -80,
        horizontalSpace: -50,
        opacity: 0.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                value.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 29,
                  color: Colors.white,
                ),
              ),
              AppText(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
