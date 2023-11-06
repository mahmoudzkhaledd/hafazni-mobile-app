import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/TargetCubit/target_cubit.dart';
import 'Widget/ActiveUserAccountBody.dart';

class AddUserTargetPage extends StatelessWidget {
  const AddUserTargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => TargetCubit(),
        child: const AddUserTargetBody(),
      ),
    );
  }
}
