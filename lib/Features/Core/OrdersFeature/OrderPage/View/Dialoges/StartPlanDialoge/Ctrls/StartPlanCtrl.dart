import 'package:get/get.dart';
import 'package:hafazni/Features/Core/OrdersFeature/Services/OrdersService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Order.dart';

class StartPlanCtrl extends GetxController {
  final Order order;
  StartPlanCtrl(this.order);
  bool loading = false;
  final OrdersServices _services = OrdersServices();
  void pay() async {
    loading = true;
    update();
    var res = await _services.startPlan(order.id);

    if (res.success) {
      Get.back<bool>(result: true);
      return;
    }
    Get.back<bool>(result: false);
    if (res.msg != null) {
      Helper.showMessage('خطأ', res.msg!);
    }
  }
}
