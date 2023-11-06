import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Blocs/AccountTypesCubit/account_type_cubit.dart';
import 'Widgets/ActiveAccountBody.dart';

class ActiveAccountPage extends StatelessWidget {
  const ActiveAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => AccountTypeCubit(),
        child: const ActiveAccountBody(),
      ),
    );
  }
}
