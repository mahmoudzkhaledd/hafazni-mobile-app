import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalancePage/Blocs/cubit/balance_cubit.dart';

import 'BalanceDetails.dart';
import 'BalancePageHeader.dart';

class BalanceBody extends StatelessWidget {
  const BalanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BalanceCubit>();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => cubit.getWallet(),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          children: const [
            BalancePageHeader(),
            SizedBox(height: 20),
            BalanceDetails(),
          ],
        ),
      ),
    );
  }
}
