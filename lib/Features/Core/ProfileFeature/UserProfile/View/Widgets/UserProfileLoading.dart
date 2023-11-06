import 'package:flutter/material.dart';

class UserProfileLoadingPage extends StatelessWidget {
  const UserProfileLoadingPage({super.key});
  Widget buildContainer(double width, double? height, [Widget? child]) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.05),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: child,
      );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          children: [
            buildContainer(
              double.infinity,
              null,
              Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black.withOpacity(0.07),
                  ),
                  const SizedBox(height: 20),
                  buildContainer(200, 15),
                  const SizedBox(height: 10),
                  buildContainer(200, 15),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildContainer(double.infinity, 60),
            const SizedBox(height: 20),
            buildContainer(double.infinity, 60),
            const SizedBox(height: 20),
            buildContainer(double.infinity, 60),
            const SizedBox(height: 20),
            buildContainer(double.infinity, 60),
          ],
        ),
      ),
    );
  }
}
