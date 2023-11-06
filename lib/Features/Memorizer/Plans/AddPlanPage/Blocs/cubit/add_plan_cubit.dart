import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/Dialoges/AddCouponsDialoge/View/AddCouponsDialoge.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/Dialoges/ShowPreqsDialoge/View/AddPreqsDialoge.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/Dialoges/ShowPreqsDialoge/View/ShowPreqsDialoge.dart';
import 'package:hafazni/Features/Memorizer/PlansService/PlansService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:meta/meta.dart';

import '../../View/Dialoges/AddCouponsDialoge/Ctrls/AddCouponsDialogeCtrl.dart';

part 'add_plan_state.dart';

class AddPlanCubit extends Cubit<AddPlanState> {
  late Plan plan;
  AddPlanCubit(Plan? p) : super(AddPlanInitial()) {
    plan = p ?? Plan();
    if (p != null) {
      for (var element in p.promoCode) {
        promoCodes.add(PromoCode()..id = element);
      }
    }
  }

  final FocusNode focusNode = FocusNode();
  final PlanService _planService = PlanService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PromoCode> promoCodes = [];
  void hideKeyboard() {
    focusNode.unfocus();
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    return super.close();
  }

  void addPreqs() async {
    String? res = await Get.dialog<String>(const AddPreqsDialoge());
    if (res != null && !plan.preRequisites.contains(res)) {
      plan.preRequisites.add(res.trim());
      emit(AddPreqsState());
    }
  }

  void removePreqs(String e) {
    plan.preRequisites.removeWhere((element) => element == e);
    emit(AddPreqsState());
  }

  void showPreqsDialoge() async {
    int old = plan.preRequisites.length;
    await Get.dialog(
      ShowPreqsDialoge(
        preqs: plan.preRequisites,
      ),
    );
    if (plan.preRequisites.length != old) {
      emit(AddPreqsState());
    }
  }

  showCouponsDialoge() async {
    if (plan.price <= 0) {
      await Helper.showMessage(
        'خطأ في الكوبونات',
        "الرجاء وضع سعر أولا للدورة قبل اختيار كوبون",
        icon: FontAwesomeIcons.moneyBill,
      );
      return;
    }
    List<PromoCode>? codes = await Get.dialog(AddCouponsDialoge(
      codes: promoCodes,
      price: plan.price,
    ));
    Get.delete<AddCouponsDialogeCtrl>();
    if (codes != null) {
      promoCodes = codes;
      emit(AddPromoCodesState());
    }
  }

  void uploadPlan(PlanState planState) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    plan.state = planState;
    plan.promoCode = promoCodes.map((e) => e.id).toList();
    var res = await Helper.showLoading(
      'جاري الحفظ',
      "الرجاء الانتظار",
      () => _planService.addPlan(plan),
    );
    if (!res.success) {
      return;
    }
    plan.id = res.data["_id"];
    await Helper.showMessage(
      'عملية ناجحة',
      "تم الحفظ",
      icon: Icons.check_circle,
    );
  }

  setPlanPrice(String e) {
    plan.price = double.tryParse(e) ?? -1;
    if (plan.promoCode.isNotEmpty || promoCodes.isNotEmpty) {
      plan.promoCode.clear();
      promoCodes.clear();
      emit(AddPromoCodesState());
    }
  }
}
