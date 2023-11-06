import 'package:hafazni/Shared/SharedColors.dart';
import 'package:flutter/material.dart';

import 'AppText.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.text,
    required this.onChange,
    this.color = AppColors.mainColor,
    this.checkColor = Colors.white,
  }) : super(key: key);
  final bool value;
  final String text;
  final Function(bool) onChange;
  final Color color;
  final Color checkColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(!value),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: 20,
                    color: checkColor,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          AppText(text),
        ],
      ),
    );
  }
}
