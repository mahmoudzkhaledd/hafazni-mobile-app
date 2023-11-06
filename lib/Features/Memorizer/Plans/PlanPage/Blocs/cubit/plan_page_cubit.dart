import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/AddPlanPage.dart';
import 'package:hafazni/Features/Memorizer/PlansService/PlansService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:meta/meta.dart';

import '../../../../../../GeneralWidgets/Dialoges/SendRequestDialoge/Ctrl/SendPlanRequestCtrl.dart';
import '../../../../../../GeneralWidgets/Dialoges/SendRequestDialoge/View/SendRequestDialoge.dart';
import '../../../../../../GeneralWidgets/QrCodeDialoge.dart';

part 'plan_page_state.dart';

class PlanPageCubit extends Cubit<PlanPageState> {
  late Plan plan;
  final bool goToUserPage;
  final PlanService _planService = PlanService();
  PlanPageCubit({
    required this.plan,
    required this.goToUserPage,
  }) : super(PlanLoadingState()) {
    getPlan();
  }

  void getPlan() async {
    emit(PlanLoadingState());
    Plan? p = await _planService.getPlan(plan.id);
    if (p == null) {
      emit(PlanFailedState());
      return;
    }
    plan = p;
    emit(PlanLoadedState());
  }

  void editPlan() async {
    await Get.to(
      () => AddPlanPage(
        plan: plan,
      ),
    );
  }

  void deletePlan() async {
    bool msg = await Helper.showYesNoMessage(
      plan.state == PlanState.hidden ? "اخفاء الدورة" : "إظهار الدورة",
      plan.state == PlanState.hidden
          ? "هل انت متأكد من إخفاء الدورة؟"
          : "هل انت متاكد من إظهار الدورة؟",
    );

    if (msg) {
      var res = await Helper.showLoading(
        'جاري الإيقاف',
        "يرجى الانتظار",
        () => _planService.hidePlan(plan.id),
      );
      if (!res.success) {
        if (res.msg != null) {
          await Helper.showMessage(
            'خطأ اثناء العميلة',
            res.msg!,
            icon: res.icon,
          );
        }
        return;
      }
      await Helper.showMessage(
        "عملية ناجحة",
        "تمت العميلة بنجاح",
        icon: Icons.check,
      );
      plan.state = PlanState.values.byName(res.data['planState']);
      emit(PlanLoadedState());
    }
  }

  void requestPlan() async {
    if (plan.orderid == null) {
      Order? res = await Get.dialog<Order>(SendRequestDialoge(
        plan: plan,
      ));
      Get.delete<SendPlanRequestCtrl>();

      if (res != null) {
        plan.orderid = res.id;
        emit(PlanLoadedState());
      }
    } else {}
  }

  void showQrCode() {
    Get.dialog(QrCodeDialoge(data: plan.qrCode));
  }
}
