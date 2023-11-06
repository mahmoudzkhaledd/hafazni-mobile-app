import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Models/PromoCode.dart';

import '../Blocs/cubit/edit_coupon_cubit.dart';
import 'Widget/EditCouponBody.dart';

class EditCouponPage extends StatelessWidget {
  const EditCouponPage({super.key, required this.code});
  final PromoCode code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('تعديل كوبون'),
      ),
      body: BlocProvider(
        create: (context) => EditCouponCubit(code),
        child: const EditCouponBody(),
      ),
    );
  }
}
