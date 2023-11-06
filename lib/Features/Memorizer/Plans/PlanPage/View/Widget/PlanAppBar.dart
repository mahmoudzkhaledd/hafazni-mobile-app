import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../GeneralWidgets/CustomIconButton.dart';
import '../../../../../../GeneralWidgets/CustomSliverAppBar.dart';
import '../../../../../../GeneralWidgets/CustomUserImage.dart';
import '../../../../../../Helper/Helper.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';
import '../../../../../Core/ProfileFeature/UserProfile/View/UserProfile.dart';
import '../../../PlansPage/View/Widgets/PriceWidget.dart';
import '../../Blocs/cubit/plan_page_cubit.dart';

class PlanAppBar extends StatelessWidget {
  const PlanAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanPageCubit>();
    return CustomSliverAppBar(
      image: 'course.jpg',
      title: cubit.plan.title,
      topDistance: 50,
      subTitle: "",
      titleBoxOpacity: 0.8,
      height: Helper.size(context).height / 2,
      titleColor: Colors.black.withOpacity(0.9),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!cubit.goToUserPage) return;
              Get.to(
                () => UserProfilePage(
                  userId: cubit.plan.memorizerData.id,
                  showPlans: false,
                ),
              );
            },
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: CustomUserImage(
                radius: 40,
                url: cubit.plan.memorizerData.profilePic,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                cubit.plan.memorizerData.fullName,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: FontFamily.black,
                  shadows: const [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              AppText(
                cubit.plan.memorizerData.country.arabicName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: FontFamily.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconButton(
                onTap: cubit.showQrCode,
                icon: Icons.qr_code,
                verticalPadding: 7,
                horizontalPadding: 7,
              ),
              const SizedBox(width: 10),
              PriceWidget(
                price: cubit.plan.price,
                afterDiscount: cubit.plan.afterDiscount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
