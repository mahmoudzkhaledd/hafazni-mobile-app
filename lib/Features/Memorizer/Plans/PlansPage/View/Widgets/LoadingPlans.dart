import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';

class LoadingPlansWidget extends StatelessWidget {
  const LoadingPlansWidget({super.key});
  Widget buildContainer(double width, double height) => CustomContainer(
        width: width,
        height: height,
        borderRadius: 4,
        backColor: Colors.black.withOpacity(0.087),
        child: const SizedBox.shrink(),
      );
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 5,
      itemBuilder: (ctx, idx) {
        return CustomContainer(
          width: double.infinity,
          marginBottom: 20,
          borderRadius: 10,
          verticalPadding: 20,
          horizontalPadding: 20,
          backColor: Colors.black.withOpacity(0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainer(200, 20),
                  buildContainer(70, 20),
                ],
              ),
              const SizedBox(height: 20),
              buildContainer(double.infinity, 90),
            ],
          ),
        );
      },
    );
  }
}
