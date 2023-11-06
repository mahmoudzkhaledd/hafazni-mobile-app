import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class FilterationBottomSheet extends StatelessWidget {
  const FilterationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            'فلترة كوبونات الخصم',
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const AppText('الكل'),
            leading: const Icon(Icons.done_all_sharp),
            onTap: () {
              Get.back<int>(result: 0);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const AppText('فعال'),
            leading: const Icon(
              Icons.local_activity_outlined,
              color: Colors.amber,
            ),
            onTap: () {
              Get.back<int>(result: 1);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const AppText('غير فعال'),
            leading: const Icon(
              Icons.lock_clock_outlined,
              color: Colors.red,
            ),
            onTap: () {
              Get.back<int>(result: 2);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
