import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalancePage/Blocs/cubit/balance_cubit.dart';
import 'package:hafazni/GeneralWidgets/DetailWidget.dart';

class BalanceDetails extends StatelessWidget {
  const BalanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BalanceCubit>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DetailWidget(
                icon: FontAwesomeIcons.coins,
                description: "\$${cubit.wallet.earn.toStringAsFixed(2)}",
                title: "الارباح",
                backColor: const Color.fromRGBO(255, 246, 237, 1),
                iconColor: const Color.fromRGBO(252, 146, 60, 1),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DetailWidget(
                icon: Icons.check,
                description: "\$${cubit.wallet.spent.toStringAsFixed(2)}",
                title: "تم إنفاقه",
                backColor: const Color.fromARGB(255, 198, 209, 255),
                iconColor: const Color.fromARGB(255, 252, 60, 102),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: DetailWidget(
            icon: Icons.lock_clock_outlined,
            description: "\$${cubit.wallet.pending.toStringAsFixed(2)}",
            title: "معلق",
            backColor: const Color.fromARGB(255, 203, 250, 203),
            iconColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
