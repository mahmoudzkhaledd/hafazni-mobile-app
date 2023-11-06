import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/BalanceFeature/TransactionsPage/Blocs/cubit/transactions_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Models/Transaction.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:intl/intl.dart';

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionsCubit>();
    if (cubit.transactions.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => cubit.getTransactions(),
        child: ListView(
          children: const [
            SizedBox(height: 90),
            LoadingFailsWidget(
              title: 'لا يوجد معاملات حتى الان',
              image: 'empty-box.png',
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => cubit.getTransactions(),
      child: ListView.builder(
        itemCount: cubit.transactions.length,
        itemBuilder: (ctx, idx) {
          final Transaction trans = cubit.transactions[idx];
          return ListTile(
            titleTextStyle: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 15,
              color: Colors.black,
            ),
            subtitleTextStyle: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: 13,
              color: Colors.black,
            ),
            title: AppText(
              Transaction.getOperationType(
                trans.operationType,
              ),
            ),
            leading: CustomImage(
              width: 40,
              trans.operationType == TransactionType.deposit
                  ? "deposit.png"
                  : trans.operationType == TransactionType.pay
                      ? "credit-card.png"
                      : trans.operationType == TransactionType.pend
                          ? "pending.png"
                          : trans.operationType == TransactionType.profit
                              ? "coin.png"
                              : "withdraw.png",
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "رقم العملية: ${trans.number}",
                ),
                AppText(
                  "تاريخ العملية: ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(trans.createdAt)}",
                ),
              ],
            ),
            trailing: CustomContainer(
              verticalPadding: 5,
              horizontalPadding: 5,
              backColor: const Color.fromRGBO(245, 117, 53, 1),
              borderRadius: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    trans.amount.toStringAsFixed(2),
                    style: TextStyle(
                      fontFamily: FontFamily.black,
                      fontSize: 13.7,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.monetization_on,
                    size: 20,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
