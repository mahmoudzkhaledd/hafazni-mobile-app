import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/View/Widget/PlanAppBar.dart';

import '../../Blocs/cubit/plan_page_cubit.dart';
import 'PlanDetails.dart';

class PlanBody extends StatelessWidget {
  const PlanBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanPageCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getPlan(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PlanAppBar(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: PlanDetails(),
          ),
        ],
      ),
    );
  }
}
