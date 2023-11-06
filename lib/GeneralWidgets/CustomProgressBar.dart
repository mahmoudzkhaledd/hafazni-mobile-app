import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.percentage,
  });

  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: const Color(0xffD9D9D9),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: (percentage * 100).toInt(),
              child: Container(
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF55CB74),
                      Color(0xFF13A795),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: ((1 - percentage) * 100).toInt(),
                child: const SizedBox()),
          ],
        ),
      ],
    );
  }
}
