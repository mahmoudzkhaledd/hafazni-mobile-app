import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/Blocs/cubit/add_plan_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import '../../../../../Models/Plan.dart';
import 'Widget/AddPlanBody.dart';

class AddPlanPage extends StatelessWidget {
  const AddPlanPage({super.key, this.plan});
  final Plan? plan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('إضافة خطة جديدة'),
      ),
      body: BlocProvider(
        create: (context) => AddPlanCubit(plan),
        child: const AddPlanBody(),
      ),
    );
  }
}
