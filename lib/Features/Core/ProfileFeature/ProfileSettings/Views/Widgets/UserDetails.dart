import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../GeneralWidgets/CustomRadioButton.dart';
import '../../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';
import '../../../../../../Shared/SharedColors.dart';
import '../../Blocs/cubit/profile_settings_cubit.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileSettingsCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextBox(
                  hintText: 'الإسم الأول',
                  initialValue: cubit.user.firstName,
                  onChanged: (e) => cubit.user.firstName = e,
                  validator: (txt) {
                    if (txt == null || txt.isEmpty || txt.length > 30) {
                      return "الرجاء كتابة اسم صحيح";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomTextBox(
                  hintText: "الإسم الأخير",
                  initialValue: cubit.user.lastName,
                  onChanged: (e) => cubit.user.lastName = e,
                  validator: (txt) {
                    if (txt == null || txt.isEmpty || txt.length > 30) {
                      return "الرجاء كتابة اسم صحيح";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextBox(
            hintText: "0xxxxxxxxxx",
            isNumber: true,
            initialValue: cubit.user.phone,
            textAlign: TextAlign.end,
            onChanged: (e) => cubit.user.phone = e,
            validator: (txt) {
              if (txt == null || txt.length > 30) {
                return "الرجاء كتابة رقم صحيح";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
            buildWhen: (previous, current) =>
                previous is ProfileSettingsInitial ||
                current is ChangeBirthdateSettingsState,
            builder: (context, state) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(FontAwesomeIcons.cakeCandles),
                onTap: cubit.changeUserBirthDate,
                title: AppText(
                  DateFormat('yyyy-MM-dd')
                      .format(cubit.user.birthdate)
                      .toString(),
                ),
                subtitle: const AppText(
                  "تاريخ الميلاد",
                ),
                tileColor: AppColors.textBoxColor,
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
            buildWhen: (previous, current) =>
                previous is ProfileSettingsInitial ||
                current is ChangeCountrySettingsState,
            builder: (context, state) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(FontAwesomeIcons.globe),
                onTap: cubit.changeCountry,
                title: AppText(cubit.user.country.arabicName.isNotEmpty
                    ? cubit.user.country.arabicName
                    : "لم يتم التحديد"),
                subtitle: const AppText(
                  "الدولة",
                ),
                tileColor: AppColors.textBoxColor,
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
            buildWhen: (previous, current) =>
                previous is ProfileSettingsInitial ||
                current is ChangeGenderSettingsState,
            builder: (context, state) {
              return Row(
                children: [
                  AppText(
                    "الجنس",
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                  CustomRadioButton<bool>(
                    text: "ذكر",
                    value: true,
                    groupValue: cubit.user.gender,
                    onChanged: cubit.changeUserGender,
                  ),
                  const SizedBox(width: 10),
                  CustomRadioButton<bool>(
                    text: "انثى",
                    value: false,
                    groupValue: cubit.user.gender,
                    onChanged: cubit.changeUserGender,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
