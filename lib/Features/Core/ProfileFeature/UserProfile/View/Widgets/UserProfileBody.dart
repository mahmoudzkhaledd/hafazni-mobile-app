import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/services/AppUser.dart';

import '../../Blocs/UserProfileCubit/user_profile_cubit.dart';
import 'MemorizerDataWidget.dart';
import 'ProfileHeader.dart';
import 'UserRatingWidget.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getUser(),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          const UserProfileHeader(),
          if (cubit.user.memorizerData != null &&
              (cubit.user.memorizerData!.state == AccountTypeState.accepted ||
                  Get.find<AppUser>().user!.id == cubit.user.id))
            Column(
              children: [
                const SizedBox(height: 20),
                if (cubit.user.memorizerData != null)
                  const Column(
                    children: [
                      UserRatingWidget(),
                      SizedBox(height: 20),
                      MemorizerDataWidget(),
                    ],
                  ),
                const SizedBox(height: 50),
              ],
            )
        ],
      ),
    );
  }
}
