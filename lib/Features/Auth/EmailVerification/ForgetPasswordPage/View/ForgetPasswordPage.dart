import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import '../Blocs/cubit/forget_password_cubit.dart';
import 'Widgets/ForgetPasswordBody.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('نسيت كلمة المرور'),
      ),
      body:  BlocProvider(
        create: (context) => ForgetPasswordCubit(),
        child:const ForgetPasswordBody(),
      ),
    );
  }
}
