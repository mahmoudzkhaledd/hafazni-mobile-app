import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalancePage/Blocs/cubit/balance_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class CreateWallet extends StatelessWidget {
  const CreateWallet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BalanceCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomImage(
              'wallet.png',
              width: 150,
            ),
            AppText(
              'انشاء محفظة للتطبيق',
              style: TextStyle(
                fontFamily: FontFamily.black,
                fontSize: 20,
              ),
            ),
            AppText(
              "انشئ محفظتك الإلكترونية لحفظ معاملاتك المالية داخل التطبيق وحتى يمكنك الدفع واستلام الارباح من خلالها",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'انشئ الان',
              onTap: cubit.createWallet,
            ),
          ],
        ),
      ),
    );
  }
}
