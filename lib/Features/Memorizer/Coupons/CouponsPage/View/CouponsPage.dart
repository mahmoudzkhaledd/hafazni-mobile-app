import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../Blocs/cubit/view_coupons_cubit.dart';
import 'Widgets/CouponsPageBody.dart';
import 'Widgets/LoadingWidget.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        title: const AppText(
          "كوبونات الخصم",
        ),
      ),
      body: BlocProvider(
        create: (context) => ViewCouponsCubit(),
        child: BlocBuilder<ViewCouponsCubit, ViewCouponsState>(
          builder: (context, state) {
            if (state is CouponsLoadingState) {
              return const CouponsLoadingWidget();
            }
            if (state is CouponsLoadedState) {
              
              return CouponsPageBody(
                coupons: state.promoCodes,
              );
            }
            return const LoadingFailsWidget(
              title: "يتعذر تحميل البيانات نظرا لضعف اللإتصال",
              image: 'not-found.png',
            );
          },
        ),
      ),
    );
  }
}
