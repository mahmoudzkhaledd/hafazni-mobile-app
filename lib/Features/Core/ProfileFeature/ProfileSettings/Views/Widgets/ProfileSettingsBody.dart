import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import '../../Blocs/cubit/profile_settings_cubit.dart';
import 'PhotoWidget.dart';
import 'UserDetails.dart';

class ProfileSettingsBody extends StatelessWidget {
  const ProfileSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileSettingsCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'تعديل حسابك',
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Center(child: PhotoWidget()),
          const SizedBox(height: 20),
          AppText(
            "بيانات الحساب",
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 20,
            ),
          ),
          const UserDetails(),
          const SizedBox(height: 20),
          CustomButton(
            text: 'تعديل',
            icon: const Icon(
              Icons.edit_calendar_outlined,
              color: Colors.white,
            ),
            onTap: cubit.editProfile,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
