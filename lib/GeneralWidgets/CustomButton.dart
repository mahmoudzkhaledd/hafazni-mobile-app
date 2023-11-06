import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedColors.dart';
import 'package:flutter/material.dart';
import 'AppText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.borderd,
    this.backgroundColor = AppColors.mainColor,
    this.textColor = Colors.white,
    this.horizontalPadding,
    this.verticalPadding,
    required this.onTap,
    this.fontSize = 13,
    this.borderWidth,
    this.icon,
    this.filled,
    this.borderColor,
    this.textStyle,
    this.borderRadius,
  });
  final TextStyle? textStyle;
  final Widget? icon;
  final String text;
  final bool? borderd;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final VoidCallback onTap;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final bool? filled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          color: filled != false ? backgroundColor : null,
          border: borderd == true
              ? Border.all(
                  width: borderWidth ?? 0,
                  color: borderColor ?? AppColors.mainColor,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 10,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AppText(
                  text,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                        color: textColor,
                        fontFamily: FontFamily.bold,
                        fontSize: fontSize ?? 13,
                      ),
                ),
              ),
              if (icon != null)
                Row(
                  children: [
                    const SizedBox(width: 10),
                    icon!,
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
