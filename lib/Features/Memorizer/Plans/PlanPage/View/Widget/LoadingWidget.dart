import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Helper/Helper.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  Widget buildContainer(double width, double height,
          [double bottomMargin = 0]) =>
      CustomContainer(
        width: width,
        height: height,
        borderRadius: 4,
        marginBottom: bottomMargin,
        backColor: Colors.black.withOpacity(0.087),
        child: const SizedBox.shrink(),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: Helper.size(context).height / 2,
          color: Colors.black.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
              const SizedBox(height: 20),
              buildContainer(200, 20),
              const SizedBox(height: 10),
              buildContainer(200, 20),
              const SizedBox(height: 10),
              buildContainer(200, 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: List.generate(
                3,
                (index) => buildContainer(double.infinity, 130, 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
