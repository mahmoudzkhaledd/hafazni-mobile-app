import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:meta/meta.dart';

import '../../../EditCouponPage/View/EditCouponPage.dart';
import '../../../../CouponsService/CouponsService.dart';
import '../../View/Widgets/FilterationBottomSheet.dart';

part 'view_coupons_state.dart';

class ViewCouponsCubit extends Cubit<ViewCouponsState> {
  ViewCouponsCubit() : super(CouponsLoadingState()) {
    getCoupons();
  }
  List<PromoCode> repo = [];
  final CouponsService _couponService = CouponsService();
  void getCoupons() async {
    emit(CouponsLoadingState());
    var res = await _couponService.getUserCoupons();
    if (!res.success) {
      emit(CouponsFailState());
      return;
    }
    try {
      repo = List.generate(
        (res.data['coupons'] as List<dynamic>).length,
        (index) => PromoCode.fromJson(res.data['coupons'][index]),
      );
      emit(CouponsLoadedState(repo));
    } catch (_) {}
  }

  onEndEdit(PromoCode code) async {
    String? res = await Get.off(() => EditCouponPage(code: code));
    if (res != null && state is CouponsLoadedState) {
      final splt = res.split(' ');
      if (splt[0] == 'remove') {
        repo.removeWhere((element) => element.id == splt[1]);
      } else if (res[0] == 'state') {}

      emit(CouponsLoadedState(repo));
    }
  }

  void shoFilterDialoge() async {
    int? res = await Get.bottomSheet(
      const FilterationBottomSheet(),
      backgroundColor: Colors.white,
    );
    if (res != null && state is CouponsLoadedState) {
      if (res == 0) {
        emit(CouponsLoadedState(repo));
        return;
      }
      final List<PromoCode> tmp = [];
      for (int i = 0; i < repo.length; i++) {
        if (repo[i].valid == (res == 1)) {
          tmp.add(repo[i]);
        }
      }
      emit(CouponsLoadedState(tmp));
    }
  }
}
