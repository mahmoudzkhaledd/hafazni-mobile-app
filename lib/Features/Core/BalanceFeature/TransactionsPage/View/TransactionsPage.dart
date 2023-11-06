import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/BalanceFeature/TransactionsPage/Blocs/cubit/transactions_cubit.dart';
import 'package:hafazni/Features/Core/BalanceFeature/TransactionsPage/View/Widgets/TransactionsBody.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Helper/Helper.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('تاريخ المعاملات'),
      ),
      body: BlocProvider(
        create: (context) => TransactionsCubit(),
        child: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsLoadingState) {
              return Helper.loadingWidget();
            } else if (state is TransactionsLoadedState) {
              return const TransactionsBody();
            }
            return const LoadingFailsWidget(
              title: 'خطأ اثناء التحميل',
              image: "empty-box.png",
            );
          },
        ),
      ),
    );
  }
}
