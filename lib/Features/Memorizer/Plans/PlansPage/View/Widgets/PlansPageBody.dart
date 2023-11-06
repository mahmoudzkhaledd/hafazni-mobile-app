import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/AddPlanPage.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/Blocs/cubit/plans_page_cubit.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/Widgets/LoadingPlans.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/CustomSliverAppBar.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/services/AppUser.dart';

import 'PlanWidget.dart';

class PlansPageBody extends StatelessWidget {
  const PlansPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlansPageCubit>();
    return Column(
      children: [
        const CustomSliverAppBar(
          image: 'plans.jpg',
          title: 'تصفح الخطط',
          subTitle: 'تصفح الخطط الخاصة بالمحفظين المقبولين',
        ),
        if (Get.find<AppUser>().user!.memorizerData != null)
          CustomContainer(
            backColor: const Color.fromRGBO(240, 240, 240, 1),
            width: double.infinity,
            verticalPadding: 10,
            horizontalPadding: 10,
            child: Row(
              children: [
                CustomButton(
                  text: 'إضافة خطة',
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  verticalPadding: 3,
                  borderRadius: 5,
                  horizontalPadding: 9,
                  onTap: () {
                    Get.to(() => const AddPlanPage());
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        BlocBuilder<PlansPageCubit, PlansPageState>(
          builder: (context, state) {
            if (state is PlansPageLoading) {
              return const Expanded(child: LoadingPlansWidget());
            }
            if (state is PlansPageLoaded) {
              if (state.plans.isEmpty) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => cubit.getPlans(),
                    child: ListView(
                      children: const [
                        LoadingFailsWidget(
                          title: 'لا يوجد خطط الى الان',
                          image: "empty-file.png",
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => cubit.getPlans(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.plans.length,
                    itemBuilder: (context, index) {
                      return PlanWidget(
                        plan: state.plans[index],
                        goToUserPage: cubit.userId == null,
                      );
                    },
                  ),
                ),
              );
            }

            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async => cubit.getPlans(),
                child: ListView(
                  children: const [
                    LoadingFailsWidget(
                      title: 'لا يوجد اي خطط حتى الان',
                      image: 'empty-box.png',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
