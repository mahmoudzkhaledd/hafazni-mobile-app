import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/OrdersFeature/SentOrders/View/SentOrders.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/PlansPage.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/services/AppUser.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../Shared/Fonts/FontModel.dart';
import '../../../../Core/BalanceFeature/BalancePage/View/BalancePage.dart';
import '../../../../Core/ProfileFeature/ProfileSettings/Views/ProfileSettings.dart';
import '../../../../Core/ProfileFeature/UserProfile/View/UserProfile.dart';
import '../../../../Memorizer/Coupons/CouponsPage/View/CouponsPage.dart';

class HomePageBottomSheet extends StatelessWidget {
  const HomePageBottomSheet({super.key});
  Widget buildContainer(String title, Widget icon, String? data) =>
      CustomContainer(
        backColor: Colors.black.withOpacity(0.1),
        verticalPadding: 13,
        horizontalPadding: 20,
        marginTop: 10,
        borderRadius: 10,
        marginBottom: 10,
        width: double.infinity,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            AppText(
              title,
              style: TextStyle(
                fontSize: 15,
                fontFamily: FontFamily.bold,
              ),
            ),
            const Spacer(),
            if (data != null)
              CircleAvatar(
                radius: 17,
                child: AppText(
                  data,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: FontFamily.black,
                  ),
                ),
              ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                "بياناتك",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                FontAwesomeIcons.houseUser,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (Get.find<AppUser>().user!.memorizerData != null &&
              Get.find<AppUser>().user!.memorizerData!.state ==
                  AccountTypeState.accepted)
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(() => PlansPage(
                          userId: Get.find<AppUser>().user!.id,
                        ));
                  },
                  child: buildContainer(
                    "الخطط",
                    const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Color.fromRGBO(244, 142, 56, 1),
                      size: 28,
                    ),
                    null,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const CouponsPage());
                  },
                  child: buildContainer(
                    "كوبونات الخصم",
                    const CustomImage(
                      'coupon.png',
                      width: 32,
                    ),
                    null,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(
                      () => const SentOrdersPage(toMe: true),
                    );
                  },
                  child: buildContainer(
                    "الطلبات الواردة",
                    const CustomImage(
                      'sent.png',
                      width: 32,
                    ),
                    null,
                  ),
                ),
              ],
            ),
          GestureDetector(
            onTap: () {
              Get.off(() => const BalancePage());
            },
            child: buildContainer(
              'الرصيد',
              const Icon(
                Icons.monetization_on,
                color: Colors.amber,
                size: 28,
              ),
              null,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.off(
                () => UserProfilePage(userId: Get.find<AppUser>().user!.id),
              );
            },
            child: buildContainer(
              'ملفي الشخصي',
              const Icon(
                Icons.person_rounded,
                color: Color.fromRGBO(145, 112, 209, 1),
                size: 28,
              ),
              null,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
