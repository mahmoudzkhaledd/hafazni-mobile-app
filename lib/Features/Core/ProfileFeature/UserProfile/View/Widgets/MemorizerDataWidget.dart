import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/AppReposetory.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../Blocs/UserProfileCubit/user_profile_cubit.dart';

class MemorizerDataWidget extends StatelessWidget {
  const MemorizerDataWidget({super.key});
  Widget buildContainer(String title, IconData icon, String? data) =>
      CustomContainer(
        backColor: const Color.fromARGB(255, 255, 255, 255),
        verticalPadding: 7,
        horizontalPadding: 20,
        marginTop: 10,
        borderRadius: 10,
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            AppText(title),
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
    final cubit = context.read<UserProfileCubit>();

    return Column(
      children: [
        CustomContainer(
          backColor: const Color.fromRGBO(247, 247, 247, 1),
          verticalPadding: 10,
          horizontalPadding: 20,
          borderRadius: 10,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "التوثيقات",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 20,
                ),
              ),
              if (!cubit.user.memorizerData!.verified &&
                  cubit.user.memorizerData!.certificant.isEmpty)
                const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.info,
                        size: 55,
                      ),
                      AppText(
                        'لا يوجد',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              if (cubit.user.memorizerData!.verified)
                buildContainer(
                  " تم التحقق من بيانات الحساب",
                  Icons.check_circle,
                  null,
                ),
              if (cubit.user.memorizerData!.certificant.isNotEmpty)
                buildContainer(
                  "تم التحقق من الإجازة الخاصة بالمحفظ",
                  Icons.fact_check_sharp,
                  null,
                )
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomContainer(
          backColor: const Color.fromRGBO(247, 247, 247, 1),
          verticalPadding: 10,
          horizontalPadding: 20,
          borderRadius: 10,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "بيانات الحساب",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 20,
                ),
              ),
              buildContainer(
                'عمليات تحفيظ ناجحة',
                Icons.settings,
                cubit.user.memorizerData!.doneTasks.toString(),
              ),
              buildContainer(
                'خطط حالية',
                FontAwesomeIcons.bolt,
                cubit.user.memorizerData!.plansCount.toString(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 20),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          initiallyExpanded: true,
          backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          collapsedBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          title: const DefaultTextStyle(
            style: TextStyle(),
            child: AppText(
              "نبذة عني",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: SingleChildScrollView(
                child: AppText(
                  cubit.user.memorizerData!.describtion,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomContainer(
          backColor: const Color.fromRGBO(247, 247, 247, 1),
          verticalPadding: 10,
          horizontalPadding: 20,
          borderRadius: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "القراءات التي أجديدها",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 20,
                ),
              ),
              if (cubit.user.memorizerData!.readings.isNotEmpty)
                ...cubit.user.memorizerData!.readings.map(
                  (e) => buildContainer(
                    AppRepository.readings[e],
                    Icons.done,
                    null,
                  ),
                )
              else
                const Center(
                  child: Column(
                    children: [
                      CustomImage(
                        'empty-box.png',
                        width: 80,
                      ),
                      AppText("لم يتم التحديد"),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
