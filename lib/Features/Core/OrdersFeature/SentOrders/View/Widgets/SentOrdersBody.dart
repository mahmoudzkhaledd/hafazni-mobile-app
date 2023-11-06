import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/OrdersFeature/SentOrders/View/Widgets/OrderWidget.dart';
import '../../../../../../GeneralWidgets/LoadingFailsWIdget.dart';
import '../../Blocs/cubit/user_orders_cubit.dart';

class SentOrdersBody extends StatelessWidget {
  const SentOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserOrdersCubit>();
    if (cubit.sentOrders.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => cubit.getOrders(),
        child: ListView(
          children: const [
            SizedBox(height: 100),
            LoadingFailsWidget(
              image: 'empty-box.png',
              title: 'لا يوجد اي طلبات الان',
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => cubit.getOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: cubit.sentOrders.length,
        itemBuilder: (context, index) {
          return OrderWidget(
            order: cubit.sentOrders[index],
          );
        },
      ),
    );
  }
}
