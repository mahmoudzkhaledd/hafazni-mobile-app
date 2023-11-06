import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/services/AppUser.dart';

import '../Blocs/cubit/balance_cubit.dart';
import 'Widgets/BalanceBody.dart';
import 'Widgets/CreateWallet.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('الرصيد'),
      ),
      body: BlocProvider(
        create: (context) => BalanceCubit(),
        child: BlocBuilder<BalanceCubit, BalanceState>(
          builder: (context, state) {
            if (Get.find<AppUser>().user!.wallet.isEmpty ||
                state is CreateWalletState) {
              return const CreateWallet();
            }
            if (state is BalanceLoadedState) {
              return const BalanceBody();
            } else if (state is BalanceLoadingState) {
              return Helper.loadingWidget();
            }
            return RefreshIndicator(
              onRefresh: () async => context.read<BalanceCubit>().getWallet(),
              child: ListView(
                children: const [
                  LoadingFailsWidget(
                    title: 'فشل تحميل البيانات الرجاء اعادة المحاولة من جديد',
                    image: 'empty-box.png',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
