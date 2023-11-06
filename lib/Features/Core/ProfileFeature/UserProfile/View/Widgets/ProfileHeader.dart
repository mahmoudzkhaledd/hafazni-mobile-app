import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ProfileFeature/ProfileSettings/Views/ProfileSettings.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/services/AppUser.dart';

import '../../../../../../GeneralWidgets/CustomIconButton.dart';
import '../../../../../../GeneralWidgets/CustomUserImage.dart';
import '../../Blocs/UserProfileCubit/user_profile_cubit.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    final textColor = (cubit.user.memorizerData != null &&
            cubit.user.memorizerData!.accountVip)
        ? Colors.white
        : Colors.black;
    return CustomContainer(
      borderRadius: 10,
      gradient: (cubit.user.memorizerData != null &&
              cubit.user.memorizerData!.accountVip)
          ? const LinearGradient(
              colors: [
                Color.fromRGBO(222, 188, 95, 1),
                Color.fromRGBO(156, 131, 67, 1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            )
          : null,
      backColor: const Color.fromRGBO(247, 247, 247, 1),
      horizontalPadding: 20,
      verticalPadding: cubit.user.id == Get.find<AppUser>().user!.id ? 20 : 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (cubit.user.id == Get.find<AppUser>().user!.id)
            Column(
              children: [
                SizedBox(
                  width: 50,
                  child: CustomIconButton(
                    backColor: Colors.green,
                    iconColor: Colors.white,
                    onTap: () {
                      Get.to(() => const ProfileSettingsPage());
                    },
                    verticalPadding: 6,
                    horizontalPadding: 0,
                    icon: Icons.edit,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          Center(
            child: CustomUserImage(
              url: cubit.user.profilePic,
              radius: 60,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: cubit.showQrCode,
              ),
              Flexible(
                child: AppText(
                  '${cubit.user.firstName}. ${cubit.user.lastName[0]}'
                          .capitalizeFirst ??
                      '${cubit.user.firstName}. ${cubit.user.lastName[0]}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 20,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 20,
                color: textColor,
              ),
              AppText(
                cubit.user.country.arabicName.isNotEmpty
                    ? cubit.user.country.arabicName
                    : "مصر",
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (cubit.user.memorizerData != null &&
              cubit.showPlans &&
              cubit.user.memorizerData!.state == AccountTypeState.accepted)
            Center(
              child: SizedBox(
                width: 200,
                child: CustomButton(
                  text: 'تصفح الخطط',
                  verticalPadding: 5,
                  backgroundColor: const Color.fromRGBO(0, 178, 45, 1),
                  icon: const Icon(
                    Icons.play_circle_rounded,
                    color: Colors.white,
                  ),
                  onTap: cubit.getPlansPage,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
