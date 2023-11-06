import 'package:flutter/material.dart';

class ShimmerSearch extends StatelessWidget {
  const ShimmerSearch({super.key});
  Widget buildContainer(double width, double height) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black.withOpacity(0.05),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 20,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.black.withOpacity(0.1),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContainer(120, 20),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildContainer(100, 15),
                    const SizedBox(width: 8),
                    buildContainer(100, 15),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
