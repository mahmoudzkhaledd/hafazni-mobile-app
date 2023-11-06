import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Models/Order.dart';

import '../Blocs/order_page_cubit.dart';
import 'Widget/OrderBody.dart';
import 'Widget/OrderLoadingWidget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key,
    required this.order,
    this.showPlanButton = true,
  });
  final Order order;
  final bool showPlanButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(order.getTitle),
      ),
      body: BlocProvider(
        create: (context) => OrderPageCubit(order.id, showPlanButton),
        child: BlocBuilder<OrderPageCubit, OrderPageState>(
          builder: (context, state) {
            if (state is OrderLoadedState) {
              return  OrderBody();
            } else if (state is OrderLoadingState) {
              return const OrderLoadingWidget();
            }
            return const LoadingFailsWidget(
              title: 'الطلب اللذي تبحث عنه غير موجود',
              image: 'empty-file.png',
            );
          },
        ),
      ),
    );
  }
}
