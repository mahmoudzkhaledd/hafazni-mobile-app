import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:hafazni/Features/Core/BalanceFeature/TransactionsPage/View/TransactionsPage.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../Blocs/cubit/balance_cubit.dart';

class BalancePageHeader extends StatelessWidget {
  const BalancePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BalanceCubit>();
    return Column(
      children: [
        CustomContainer(
          width: double.infinity,
          verticalPadding: 20,
          horizontalPadding: 20,
          borderRadius: 15,
          backColor: const Color.fromRGBO(73, 72, 222, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                "رصيدك الحالي",
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: 17,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              AppText(
                "\$${cubit.wallet.balance.toStringAsFixed(2)}",
                style: TextStyle(
                  fontFamily: FontFamily.black,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              CustomContainer(
                width: double.infinity,
                borderRadius: 10,
                //horizontalPadding: 20,
                // verticalPadding: 10,
                backColor: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomIconButton(
                        icon: Icons.arrow_circle_up_rounded,
                        verticalPadding: 10,
                        onTap: cubit.charge,
                        text: 'شحن',
                      ),
                    ),
                    Expanded(
                      child: CustomIconButton(
                        icon: Icons.arrow_circle_down_rounded,
                        verticalPadding: 10,
                        onTap: cubit.pull,
                        text: 'سحب',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          onTap: () {
            Get.to(() => const TransactionsPage());
          },
          leading: const Icon(Icons.history),
          title: DefaultTextStyle(
            style: const TextStyle(),
            child: AppText(
              'تاريخ المعاملات',
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
