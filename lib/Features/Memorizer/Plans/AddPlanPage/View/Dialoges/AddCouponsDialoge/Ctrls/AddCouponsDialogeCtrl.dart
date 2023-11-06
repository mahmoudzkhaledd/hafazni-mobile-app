import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/CouponsService/CouponsService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/PromoCode.dart';

class AddCouponsDialogeCtrl extends GetxController {
  AddCouponsDialogeCtrl(List<PromoCode> codes, this.price) {
    refreshCoupons();
    for (var cde in codes) {
      selectedCodes[cde.id] = cde;
    }
  }
  double price;
  bool fail = false;
  bool loading = false;
  List<PromoCode> promoCodes = [];
  Map<String, PromoCode> selectedCodes = {};
  final CouponsService _couponsService = CouponsService();
  void refreshCoupons() async {
    promoCodes.clear();
    loading = true;
    update();
    var res = await _couponsService.getUserCoupons(price: price);
    loading = false;
    update();
    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          'خطأ في الكوبونات',
          res.msg!,
          icon: res.icon,
        );
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      fail = true;
      update();
      return;
    }

    for (var x in res.data['coupons']) {
      final p = PromoCode.fromJson(x);
      promoCodes.add(p);
    }
    for (var x in selectedCodes.keys) {
      if (promoCodes.firstWhereOrNull((element) => element.id == x) == null) {
        selectedCodes.remove(x);
      }
    }
    update();
  }

  void selectPrCode(PromoCode code, bool val) {
    if (val) {
      selectedCodes[code.id] = code;
    } else {
      selectedCodes.remove(code.id);
    }
    update();
  }
}
