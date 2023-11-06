import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/OrdersFeature/OrderPage/View/Dialoges/StartPlanDialoge/Ctrls/StartPlanCtrl.dart';
import 'package:hafazni/Features/Core/OrdersFeature/Services/OrdersService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:meta/meta.dart';

import '../../../../../GeneralWidgets/Dialoges/SendRequestDialoge/Ctrl/SendPlanRequestCtrl.dart';
import '../../../../../GeneralWidgets/Dialoges/SendRequestDialoge/View/SendRequestDialoge.dart';
import '../View/Dialoges/StartPlanDialoge/View/StartPlanDialoge.dart';

part 'order_page_state.dart';

class OrderPageCubit extends Cubit<OrderPageState> {
  late Order order;
  final String id;
  final bool showPlanButton;
  final OrdersServices _ordersServices = OrdersServices();
  OrderPageCubit(this.id, this.showPlanButton) : super(OrderLoadingState()) {
    getOrder();
  }
  void getOrder() async {
    emit(OrderLoadingState());
    Order? o = await _ordersServices.getOrder(id);
    if (o != null) {
      order = o;
      emit(OrderLoadedState());
    } else {
      emit(OrderFailedState());
    }
  }

  void changeOrderState(OrderState state) async {
    String msg = "إلغاء الطلب";
    String content = "هل انت متأكد من الغاء الطب؟";
    if (state == OrderState.accepted) {
      msg = "قبول الطلب";
      content = "هل انت متأكد من قبول الطلب؟";
    } else if (state == OrderState.refused) {
      msg = "رفض الطلب";
      content = "هل انت متأكد من رفض الطلب؟";
    }
    bool res = await Helper.showYesNoMessage(
      msg,
      content,
    );
    if (res) {
      var response = await Helper.showLoading(
        "جاري الارسال",
        "الرجاء الانتظار",
        () => _ordersServices.changeOrderState(id, state),
      );
      if (response.success) {
        order = Order.fromJson(response.data['order']);
       
        emit(OrderLoadedState());
      } else if (response.msg != null) {
        await Helper.showMessage(
          response.success ? "عملية ناجحة" : "عملية فاشلة",
          response.msg!,
          icon: response.success ? Icons.check : null,
        );
      }
    }
  }

  void editOrder() async {
    Order? o = await Get.dialog<Order>(SendRequestDialoge(
      plan: order.plan,
      order: order,
    ));
    Get.delete<SendPlanRequestCtrl>();
    if (o != null) {
      order = o;
      emit(OrderLoadedState());
    }
  }

  void startPlan() async {
    bool? res = await Get.dialog<bool>(StartPlanDialoge(
      order: order,
    ));
    Get.delete<StartPlanCtrl>();
    if (res == true) {
      order.state = OrderState.running;
      emit(OrderLoadedState());
    }
  }
}
