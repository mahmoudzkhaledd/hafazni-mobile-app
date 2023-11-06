import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import '../Blocs/cubit/profile_settings_cubit.dart';
import 'Widgets/ProfileSettingsBody.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("تعديل الحساب"),
      ),
      body: BlocProvider(
        create: (context) => ProfileSettingsCubit(),
        child: const ProfileSettingsBody(),
      ),
    );
  }
}
