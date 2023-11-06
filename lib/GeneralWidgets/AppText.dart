import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:flutter/material.dart';

enum TextLanguage {
  arabic,
  english,
}

enum Gender {
  male,
  female,
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.textScaleFactor,
    this.language,
    this.overflow,
    this.maxLines,
  });

  static TextLanguage defaultLanguage = TextLanguage.english;
  final String text;
  final TextLanguage? language;
  final double? textScaleFactor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      style: style == null
          ? TextStyle(
              fontFamily: FontFamily.regular,
            )
          : style!.fontFamily == null
              ? style!.copyWith(
                  fontFamily: FontFamily.regular,
                )
              : style,
    );
  }
}
