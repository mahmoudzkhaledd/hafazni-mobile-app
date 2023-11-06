import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';

import '../Blocs/UserProfileCubit/user_profile_cubit.dart';
import 'Widgets/UserProfileBody.dart';
import 'Widgets/UserProfileLoading.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.userId,
    this.showPlans = true,
  });
  final String userId;
  final bool showPlans;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('الملف الشخصي'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        
      ),
      body: BlocProvider(
        create: (context) => UserProfileCubit(userId,showPlans),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const UserProfileLoadingPage();
            }
            if (state is UserLoadedState) {
              return  const UserProfileBody();
            }
            return const LoadingFailsWidget(
              title: 'المستخدم المطلوب غير موجود',
              image: 'not-found.png',
            );
          },
        ),
      ),
    );
  }
}
