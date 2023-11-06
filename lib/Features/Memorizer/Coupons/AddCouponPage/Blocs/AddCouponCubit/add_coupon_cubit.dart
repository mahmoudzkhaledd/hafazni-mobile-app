import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:meta/meta.dart';

import '../../../../CouponsService/CouponsService.dart';

part 'add_coupon_state.dart';

class AddCouponCubit extends Cubit<AddCouponState> {
  final PromoCode promoCode = PromoCode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double? tryCoupon;
  String? tryCouponError;
  final CouponsService _addCouponService = CouponsService();
  AddCouponCubit() : super(AddCouponInitial());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }

  void togglePrecentage(bool val) {
    promoCode.percentage = val;
    emit(ChangePercentageState());
  }

  void getRandomString() {
    Random _rnd = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String str = String.fromCharCodes(
      Iterable.generate(
        8,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
    promoCode.code = str;
    textEditingController.text = str;
  }

  void changeDiscount(String val) {
    promoCode.discount = double.tryParse(val) ?? -1;
  }

  void applyCoupon() {
    if (tryCoupon != null &&
        !promoCode.percentage &&
        promoCode.discount > tryCoupon!) {
      tryCouponError = "يجب أن يكون المبلغ أكبر من الخصم";
    } else {
      tryCouponError = null;
    }
    emit(TryCouponState(tryCoupon));
  }

  void addCoupon() async {
    // bool dates = true;
    // if (promoCode.endingDate != null) {
    //   dates = (promoCode.startingDate ?? DateTime.now())
    //           .compareTo(promoCode.endingDate!) <
    //       0;
    // }
    // if (!dates) {
    //   await Helper.showMessage(
    //     'خطأ في التواريخ',
    //     "يجب أن يكون تاريخ الإنتهاء اكبر من تاريخ البدء",
    //     icon: Icons.date_range,
    //   );
    //   return;
    // }
    if (!formKey.currentState!.validate()) {
      return;
    }
    promoCode.startingDate ??= DateTime.now();
    //promoCode.endingDate ??= DateTime.now().add(const Duration(days: 1));

    promoCode.startingDate = DateTime(
      promoCode.startingDate!.year,
      promoCode.startingDate!.month,
      promoCode.startingDate!.day,
    );
    if (promoCode.endingDate != null) {
      promoCode.endingDate = DateTime(
        promoCode.endingDate!.year,
        promoCode.endingDate!.month,
        promoCode.endingDate!.day,
      );
    }

    var res = await Helper.showLoading(
      "جاري الإضافة",
      "يرجى لانتظار قليلا",
      () => _addCouponService.addCoupon(promoCode),
    );

    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          'خطا أثناء الإضافة',
          res.msg!,
          icon: res.icon,
        );
      } else if (!res.internet) {
        await Helper.showMessage(
          'خطا أثناء الإضافة',
          "خطأ غير معروف الرجاء المحاولة مرة اخرى",
          icon: Icons.info,
        );
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      return;
    }
    Get.find<AppUser>().user!.memorizerData!.promoCodes.add(
          res.data['_id'],
        );
    await Helper.showMessage(
      "عملية ناجحة",
      "تم إضافة الكوبون بنجاح",
      icon: FontAwesomeIcons.check,
    );
  }

  void chooseDate(bool start) async {
    final strt = promoCode.startingDate ?? DateTime.now();
    DateTime? res = await showDatePicker(
      context: Get.context!,
      initialDate: start
          ? strt
          : promoCode.endingDate ?? strt.add(const Duration(days: 1)),
      //strt.add(const Duration(days: 1)),
      firstDate: start ? DateTime.now() : strt.add(const Duration(days: 1)),
      // strt.add(const Duration(days: 1)),
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
      emit(ChangeCouponDateState());
    }
  }
}
