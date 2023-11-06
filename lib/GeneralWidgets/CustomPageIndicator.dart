import 'package:hafazni/Shared/SharedColors.dart';
import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    super.key,
    this.circleColor = AppColors.secondaryRedColor,
    required this.itemCount,
    required this.currentIndex,
  });
  final Color circleColor;
  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          margin: EdgeInsets.only(
            right: index == itemCount - 1 ? 0 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: circleColor,
          ),
          width: index == currentIndex ? 30 : 7,
          height: 7,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
        ),
      ),
    );
  }
}
