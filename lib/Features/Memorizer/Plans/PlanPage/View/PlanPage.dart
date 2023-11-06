import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/Blocs/cubit/plan_page_cubit.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/View/Widget/LoadingWidget.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/View/Widget/PlanBody.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Models/Plan.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({
    super.key,
    required this.plan,
    required this.goToUserPage,
  });
  final Plan plan;
  final bool goToUserPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => PlanPageCubit(
          plan: plan,
          goToUserPage:goToUserPage,
        ),
        child: BlocBuilder<PlanPageCubit, PlanPageState>(
          builder: (context, state) {
            if (state is PlanLoadedState) {
              return PlanBody();
            } else if (state is PlanLoadingState) {
              return const LoadingWidget();
            }
            return const LoadingFailsWidget(
              title: 'الخطة المطلوبة غير موجودة',
              image: 'not-found.png',
            );
          },
        ),
      ),
    );
  }
}
