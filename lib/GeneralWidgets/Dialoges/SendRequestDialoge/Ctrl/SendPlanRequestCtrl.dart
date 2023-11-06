import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/PlansService/PlansService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/services/AppUser.dart';

import '../../../../Models/Plan.dart';

class SendPlanRequestCtrl extends GetxController {
  final Plan plan;
  Order order = Order();
  bool loadingCoupon = false;
  String code = "";
  String? error;
  final _plansService = PlanService();
  SendPlanRequestCtrl(this.plan, Order? o) {
    if (o != null) {
      order = o;
    } else {
      order.planId = plan.id;
      order.userFrom = Get.find<AppUser>().user!.id;
      order.memorizerTo = plan.memorizerData.id;
    }
    if (order.promoCode != null) {
      code = order.promoCode!.code;
    }
  }
  final _planService = PlanService();

  void tryCoupon() async {
    if (code.length != 8) {
      if (code.isEmpty) {
        order.promoCode = null;
        error = null;
      } else {
        error = "يجب ان يكون الكون 8 ارقام";
      }
      update();
      return;
    }
    loadingCoupon = true;
    update();
    order.promoCode = await _planService.getPlanPromoCode(code, plan.id);
    loadingCoupon = false;
    if (order.promoCode == null) {
      error = "الكوبون غير صالح";
    } else {
      error = null;
    }

    loadingCoupon = false;
    update();
  }

  void sendRequest() async {
    var res = await Helper.showLoading(
      'جاري ارسال طلبك',
      "الرجاء الانتظار",
      () => _plansService.sendOrderRequest(order),
    );

    if (!res.success) {
      Get.back<Order>(result: null);
      if (res.msg != null) {
        await Helper.showMessage(
          "خطأ اثناء الارسال",
          res.msg!,
          icon: res.icon,
        );
      }
      return;
    }
    order = Order.fromJson(res.data['order']);

    Get.back<Order>(result: order);

    await Helper.showMessage(
      "عملية ناجحة",
      "تم الارسال بنجاح",
      icon: Icons.check,
    );

    
  }
}
