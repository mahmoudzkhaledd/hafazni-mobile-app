import 'package:hafazni/Shared/SharedColors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.verticalPadding,
    this.horizontalPadding,
    this.marginRight,
    this.borderWidth,
    this.borderColor,
    this.width,
    this.height,
    this.marginBottom,
    this.backColor,
    this.constraints,
    this.marginTop,
    this.gradient,
    this.boxShadow,
  });
  final double? borderRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? marginRight;
  final double? width;
  final double? height;
  final double? borderWidth;
  final double? marginBottom;
  final double? marginTop;
  final Color? borderColor;
  final Color? backColor;
  final Widget child;
  final BoxConstraints? constraints;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: constraints,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: backColor ?? AppColors.mainColor,
        border: borderWidth != null
            ? Border.all(
                width: borderWidth ?? 0,
                color: borderColor ?? Colors.white,
              )
            : null,
      ),
      width: width,
      height: height,
      margin: EdgeInsets.only(
        right: marginRight ?? 0,
        bottom: marginBottom ?? 0,
        top: marginTop ?? 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 0,
      ),
      child: child,
    );
  }
}
