import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/Shared/SharedColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Shared/Fonts/FontModel.dart';
import 'AppText.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    super.key,
    this.hintText,
    this.controller,
    this.isPassword,
    this.icon,
    this.onChanged,
    this.showEyeIcon,
    this.onChangeVisability,
    this.initialValue,
    this.title,
    this.errorText,
    this.textAlign,
    this.letterSpacing,
    this.isNumber,
    this.maxLength,
    this.backgroundColor = AppColors.textBoxColor,
    this.borderColor = AppColors.mainColor,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderRadius,
    this.isDecimal,
    this.englishOnly,
    this.suffixIcon,
    this.spaces = true,
    this.isEmail,
    this.isPasswordInput,
    this.textDirection,
  });
  final TextDirection? textDirection;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String? title;
  final double? letterSpacing;
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? isDecimal;
  final Color? borderColor;
  final IconData? icon;
  final Function(String)? onChanged;
  final bool? showEyeIcon;
  final VoidCallback? onChangeVisability;
  final String? initialValue;
  final String? errorText;
  final TextAlign? textAlign;
  final bool? isNumber;
  final bool? isEmail;
  final bool? isPasswordInput;
  final bool? englishOnly;
  final bool? spaces;
  final int? maxLength;
  final int? maxLines;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final double? borderRadius;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            AppText(
              title!,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: 15,
              ),
            ),
          if (title != null) const SizedBox(height: 5),
          TextFormField(
            textDirection: textDirection,
            maxLines: isPassword != true ? maxLines : 1,
            obscureText: isPassword == true,
            validator: validator,
            onChanged: onChanged,
            initialValue: initialValue,
            style: TextStyle(
              fontFamily: FontFamily.bold,
              letterSpacing: letterSpacing,
              color: Colors.black,
            ),
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: (isNumber == true || isDecimal == true)
                ? TextInputType.number
                : isEmail == true
                    ? TextInputType.emailAddress
                    : isPasswordInput == true
                        ? TextInputType.visiblePassword
                        : null,
            textAlign: textAlign ?? TextAlign.start,
            inputFormatters: isNumber == true
                ? [FilteringTextInputFormatter.digitsOnly]
                : isDecimal == true
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ]
                    : englishOnly == true
                        ? [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                  '[a-z${spaces == true ? " " : ""}A-Z${spaces == true ? " " : ""}0-9]'),
                            )
                          ]
                        : null,
            maxLength: maxLength,
            autofillHints: [
              if (isEmail == true) AutofillHints.newUsername,
              if (isPasswordInput == true) AutofillHints.newPassword,
            ],
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              counterText: "",
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              errorText: errorText,
              prefixIcon: icon != null ? Icon(icon) : null,
              suffixIcon: showEyeIcon == true
                  ? IconButton(
                      onPressed: onChangeVisability,
                      icon: Icon(
                        isPassword == true
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.black,
                        size: 24,
                      ),
                    )
                  : suffixIcon,
              hintStyle: TextStyle(
                fontSize: 15,
                fontFamily: FontFamily.medium,
                letterSpacing: letterSpacing,
              ),
              labelStyle: TextStyle(
                fontSize: 15,
                fontFamily: FontFamily.medium,
                letterSpacing: letterSpacing,
              ),
              errorStyle: TextStyle(
                fontSize: 13,
                fontFamily: FontFamily.medium,
              ),
              fillColor: backgroundColor,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
