import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hafazni/Models/PromoCode.dart';

import '../../../../../../GeneralWidgets/LoadingFailsWIdget.dart';
import '../../Blocs/cubit/view_coupons_cubit.dart';
import 'FilterationWidget.dart';
import 'PromoCodeWidget.dart';

class CouponsPageBody extends StatelessWidget {
  const CouponsPageBody({super.key, required this.coupons});
  final List<PromoCode> coupons;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewCouponsCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.getCoupons(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const FilterationWidget(),
          const SizedBox(height: 20),
          if (coupons.isNotEmpty)
            ...List.generate(
              coupons.length,
              (index) => CouponWidget(
                code: coupons[index],
              ),
            )
          else
            const Center(
              child: LoadingFailsWidget(
                title: 'لم يتم إضافة كوبونات',
                image: 'empty-box.png',
              ),
            )
        ],
      ),
    );
  }
}
