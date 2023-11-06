import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/Blocs/cubit/plans_page_cubit.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/Widgets/PlansPageBody.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key, this.userId});
  final String? userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => PlansPageCubit(userId),
        child: const PlansPageBody(),
      ),
    );
  }
}
