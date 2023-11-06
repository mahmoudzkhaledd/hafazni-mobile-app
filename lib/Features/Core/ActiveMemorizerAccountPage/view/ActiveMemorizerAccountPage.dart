import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ActiveMemorizerAccountPage/Blocs/MemorizerAccountCubit/memorizer_account_cubit.dart';

import 'Widgets/MemorizerAccountBody.dart';

class ActiveMemozierAccountPage extends StatelessWidget {
  const ActiveMemozierAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => MemorizerAccountCubit(),
        child: const ActiveMemorizerAccountBody(),
      ),
    );
  }
}
