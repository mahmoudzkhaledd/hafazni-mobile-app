import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Auth/SignupPage/Blocs/SignupCubit/signup_cubit.dart';
import 'package:hafazni/GeneralWidgets/CustomBackground.dart';

import 'Widgets/SignupBody.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SignupCubit(),
        child: const CustomBackground(child: SafeArea(child: SignupBody())),
      ),
    );
  }
}
