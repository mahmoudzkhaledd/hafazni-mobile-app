import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import '../Blocs/AddCouponCubit/add_coupon_cubit.dart';
import 'Widget/AddCouponBody.dart';

class AddCouponPage extends StatelessWidget {
  const AddCouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('إضافة كوبون جديد'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => AddCouponCubit()),
        ],
        child: const AddCouponBody(),
      ),
    );
  }
}
