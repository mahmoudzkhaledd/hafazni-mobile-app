import 'package:flutter/material.dart';
import 'package:hafazni/Features/Home/HomePage/View/Widgets/CustomAppBar.dart';
import 'package:hafazni/Features/Home/HomePage/View/Widgets/ProgressWidget.dart';
import 'package:hafazni/Models/Group.dart';

import 'Widgets/PaymentCards.dart';
import 'Widgets/RunningPrograms.dart';
import 'Widgets/TodayPartWidget.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomAppBar(
              onOpenDrawer: Scaffold.of(context).openDrawer,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  //if (Get.find<AppUser>().user!.userData != null)
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      ProgressWidget(progress: 0.27),
                      SizedBox(height: 30),
                      TodayPartWidget(),
                      SizedBox(height: 20),
                    ],
                  ),
                  const PaymentCards(),
                  const SizedBox(height: 20),
                  RunningPrograms(
                    groups: [
                      Group()..name = "مجموعة تحفيظ القران",
                      Group()..name = "مجموعة تحفيظ القران",
                      Group()..name = "مجموعة تحفيظ القران",
                      Group()..name = "مجموعة تحفيظ القران",
                      Group()..name = "مجموعة تحفيظ القران",
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
