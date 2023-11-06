import 'package:get/get.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalanceServices/BalanceServices.dart';
import 'package:hafazni/Helper/Helper.dart';

class ChargeDialogeCtrl extends GetxController {
  double? chargePrice;
  String? err;
  bool loading = false;
  final String walletId;
  ChargeDialogeCtrl(this.walletId);
  final _services = BalanceServices();
  void charge() async {
    if (chargePrice == null || chargePrice == 0) {
      err = "يجب ادخال مبلغ ليتم الشحن";
      update();
      return;
    }
    err = null;
    loading = true;
    update();
    var res = await _services.charge(
      chargePrice!,
      walletId,
    );
    if (res != null) {
      if (res.statusCode == 200) {
        Get.back<double>(result: res.data['balance'] * 1.0);
        await Helper.showMessage(
          'عملية ناجحة',
          'تم الشحن بنجاح',
        );
      } else if (res.statusCode == 401) {
        Get.back<double>(result: null);
        await Helper.showMessage(
          'عملية فاشلة',
          "لا يوجد لك صلاحيات للقيام بهذه العملية",
        );
      }
    }
    // loading = false;
    // update();
  }
}
