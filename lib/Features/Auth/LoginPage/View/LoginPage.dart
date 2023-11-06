import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/CustomBackground.dart';

import '../Blocs/LoginCubit/login_cubit.dart';
import 'Widgets/LoginBody.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: const CustomBackground(
          child: LoginBody(),
        ),
      ),
    );
  }
}
