import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:meta/meta.dart';

import '../../../../CouponsService/CouponsService.dart';

part 'edit_coupon_state.dart';

class EditCouponCubit extends Cubit<EditCouponState> {
  late final PromoCode promoCode;
  late final String oldName;
  EditCouponCubit(PromoCode pc) : super(EditCouponInitial()) {
    promoCode = pc.copy();
    oldName = pc.name;
  }
  final CouponsService _couponService = CouponsService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void chooseDate(bool start) async {
    var strt = promoCode.startingDate ?? DateTime.now();
    if (strt.isBefore(DateTime.now())) {
      strt = DateTime.now();
    }
    DateTime? res = await showDatePicker(
      context: Get.context!,
      initialDate: start
          ? strt
          : promoCode.endingDate ?? strt.add(const Duration(days: 1)),
      firstDate: start ? strt : strt.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30 * 5)),
    );
    if (res != null) {
      if (start) {
        promoCode.startingDate = res;
        if (promoCode.endingDate != null &&
            res.isAfter(promoCode.endingDate!)) {
          promoCode.endingDate = res.add(const Duration(days: 1));
        }
      } else {
        promoCode.endingDate = res;
      }
      emit(ChangeEditCouponDateState());
    }
  }

  void stopCoupon() async {
    bool ok = await Helper.showYesNoMessage(
      "ايقاف الكوبون",
      "هل أنت متأكد من ايقاف الكوبون؟",
      icon: Icons.info,
    );
    if (ok) {
      var res = await Helper.showLoading(
        'ايقاف الكوبون',
        'جاري ايقاف الكوبون',
        () => _couponService.changeCouponState(promoCode.id, !promoCode.valid),
      );

      if (!res.success) {
        if (res.msg != null) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            res.msg!,
            icon: res.icon,
          );
        } else if (!res.internet) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            'الرجاء المحاولة مرة اخرى',
          );
        }
        return;
      }
      promoCode.valid = !promoCode.valid;
      emit(ChangeEditCouponStateState());
    }
  }

  void save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    bool ok = await Helper.showYesNoMessage(
      "حفظ التعديلات",
      "هل أنت متأكد؟",
      icon: Icons.save,
    );
    if (ok) {
      var res = await Helper.showLoading(
        'ايقاف الكوبون',
        'جاري ايقاف الكوبون',
        () => _couponService.updatePromoCode(promoCode),
      );
      if (!res.success) {
        if (res.msg != null) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            res.msg!,
            icon: res.icon,
          );
        } else if (!res.internet) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            'الرجاء المحاولة مرة اخرى',
          );
        }
        return;
      }
      await Helper.showMessage(
        'عملية ناجحة',
        "تم حفظ التعديلات بنجاح",
        icon: Icons.check_circle,
      );
    }
  }

  void deleteCoupon() async {
    bool ok = await Helper.showYesNoMessage(
      "حذف الكوبون",
      "هل أنت متأكد من حذف الكوبون؟",
      icon: Icons.delete,
    );
    if (ok) {
      var res = await Helper.showLoading(
        'حذف الكوبون',
        'جاري حذف الكوبون',
        () => _couponService.deleteCoupon(promoCode.id),
      );

      if (!res.success) {
        if (res.msg != null) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            res.msg!,
            icon: res.icon,
          );
        } else if (!res.internet) {
          await Helper.showMessage(
            'عملية غير ناجحة',
            'الرجاء المحاولة مرة اخرى',
          );
        }
        return;
      }
      await Helper.showMessage(
        'عملية ناجحة',
        "تم حذف الكوبون بنجاح",
        icon: Icons.check,
      );
      Get.back<String>(result: "remove ${promoCode.id}");
    }
  }
}
