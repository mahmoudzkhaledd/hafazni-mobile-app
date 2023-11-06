import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class FiltersWidget extends StatelessWidget {
  const FiltersWidget({
    super.key,
    required this.img,
    required this.title,
    required this.onTap,
    this.selected = false,
  });
  final String? img;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 45,
          backgroundColor: !selected ? Colors.white : Colors.green.shade300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (img != null)
                CustomImage(
                  img!,
                  width: 35,
                ),
              AppText(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.black,
                  color: !selected ? Colors.black : Colors.white,
                  fontSize: img != null ? 13 : 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
