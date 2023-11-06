import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ActiveAccountPage/View/ActiveAccountPage.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/view/SearchAndFilterPage.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/PlansPage.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../../../services/AppUser.dart';
import '../../../../Core/OrdersFeature/SentOrders/View/SentOrders.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontFamily: FontFamily.bold,
      color: Colors.black,
      fontSize: 16,
    );
    return ListView(
      children: [
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            'تفعيل حساب',
          ),
          leading: const Icon(Icons.check_circle),
          onTap: () {
            Get.to(() => const ActiveAccountPage());
          },
        ),
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            'تصفح المحفظين',
          ),
          leading: const Icon(FontAwesomeIcons.users),
          onTap: () {
            Get.to(() => const SearchAndFilterPage());
          },
        ),
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            'تصفح الخطط',
          ),
          leading: const Icon(FontAwesomeIcons.solidCirclePlay),
          onTap: () {
            Get.to(() => const PlansPage());
          },
        ),
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            "الطلبات المرسلة",
          ),
          leading: const Icon(FontAwesomeIcons.paperPlane),
          onTap: () {
            Get.to(() => const SentOrdersPage());
          },
        ),
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            "أنشطة جارية",
          ),
          leading: const Icon(FontAwesomeIcons.gears),
          onTap: () {
            Get.to(() => const SentOrdersPage());
          },
        ),
        ListTile(
          titleTextStyle: style,
          title: const AppText(
            "تسجيل الخروج",
          ),
          leading: const Icon(Icons.login),
          onTap: () async {
            bool res = await Helper.showYesNoMessage(
                'تسجيل الخروج', "هل انت متاكد من تسجيل الخروج؟");
            if (res) {
              await Helper.showLoading(
                "تسجيل الخروج",
                "جاري تسجيل الخروج",
                () => Get.find<AppUser>().signOut(),
              );
            }
          },
        ),
      ],
    );
  }
}
