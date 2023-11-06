import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';

import '../Blocs/cubit/user_orders_cubit.dart';
import 'Widgets/LoadingWidget.dart';
import 'Widgets/SentOrdersBody.dart';

class SentOrdersPage extends StatelessWidget {
  const SentOrdersPage({
    super.key,
    this.toMe = false,
  });
  final bool toMe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('الطلبات المرسلة'),
      ),
      body: BlocProvider(
        create: (context) => UserOrdersCubit(toMe),
        child: BlocBuilder<UserOrdersCubit, UserOrdersState>(
          builder: (context, state) {
            if (state is LoadingOrdersState) {
              return const LoadingWidgetOrders();
            } else if (state is LoadedOrdersState) {
              return const SentOrdersBody();
            }
            return const LoadingFailsWidget(
              image: 'empty-box.png',
              title: 'لا يوجد اي طلبات الان',
            );
          },
        ),
      ),
    );
  }
}
