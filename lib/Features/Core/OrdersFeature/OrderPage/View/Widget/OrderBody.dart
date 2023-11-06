import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Models/Order.dart';
import '../../../../../../services/AppUser.dart';
import '../../Blocs/order_page_cubit.dart';
import 'DescriptionOrderWidget.dart';
import 'OrderPageHeader.dart';
import 'OrderTimeline.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderPageCubit>();
    final order = cubit.order;
    final currUserId = Get.find<AppUser>().user!.id;
    return RefreshIndicator(
      onRefresh: () async => cubit.getOrder(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          OrderPageHeader(),
          const SizedBox(height: 20),
          if (order.state != OrderState.canceled ||
              currUserId == order.userFrom)
            const OrderDescriptionWidget(),
          const SizedBox(height: 20),
          if (cubit.order.state != OrderState.canceled &&
              cubit.order.state != OrderState.running)
            OrderTimeline(
              state: cubit.order.state,
            )
          else
            Column(
              children: [
                const SizedBox(height: 30),
                LoadingFailsWidget(
                  title: cubit.order.state == OrderState.canceled
                      ? 'تم الغاء الطلب من قبل الطالب'
                      : "الدورة جارية",
                  image: cubit.order.state == OrderState.canceled
                      ? 'canceled.png'
                      : "settings.png",
                  imageWidth: 100,
                ),
              ],
            ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
