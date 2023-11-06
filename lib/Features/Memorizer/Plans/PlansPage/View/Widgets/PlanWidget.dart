import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/View/PlanPage.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/Widgets/PriceWidget.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../../../../Models/Plan.dart';
import '../../../../../../GeneralWidgets/SubUserDescription.dart';

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.plan,
    required this.goToUserPage,
  });
  final Plan plan;
  final bool goToUserPage;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Get.to(() => PlanPage(
              plan: plan,
              goToUserPage: goToUserPage,
            ));
      },
      child: CustomContainer(
        marginBottom: 20,
        verticalPadding: 10,
        horizontalPadding: 10,
        borderRadius: 10,
        backColor: const Color.fromARGB(255, 240, 240, 239),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AppText(
                    plan.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontFamily.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                PriceWidget(
                  price: plan.price,
                  afterDiscount: plan.afterDiscount,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomContainer(
              backColor:
                  const Color.fromRGBO(250, 250, 250, 1).withOpacity(0.5),
              constraints: const BoxConstraints(
                maxHeight: 150,
              ),
              verticalPadding: 5,
              horizontalPadding: 5,
              borderRadius: 10,
              width: double.infinity,
              child: AppText(
                plan.description,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SubUserDescription(
                  fullName: plan.memorizerData.fullName,
                  id: plan.memorizerData.id,
                  profilePic: plan.memorizerData.profilePic,
                  goToUserPage: goToUserPage,
                ),
                const Spacer(),
                CustomContainer(
                  backColor: const Color.fromRGBO(250, 250, 250, 1),
                  verticalPadding: 3,
                  horizontalPadding: 8,
                  borderRadius: 10,
                  child: Row(
                    children: [
                      AppText("${plan.students}"),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.person,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
