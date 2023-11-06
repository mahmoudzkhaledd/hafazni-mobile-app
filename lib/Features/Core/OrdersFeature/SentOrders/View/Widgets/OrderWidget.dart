import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/OrdersFeature/SentOrders/Blocs/cubit/user_orders_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../../../../GeneralWidgets/SubUserDescription.dart';
import '../../../../../../Helper/Helper.dart';
import '../../../OrderPage/View/OrderPage.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserOrdersCubit>();
    final toMe = cubit.toMe;
    final User user = toMe ? order.student : order.memorizer;
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderPage(order: order));
      },
      child: CustomContainer(
        width: double.infinity,
        verticalPadding: 10,
        horizontalPadding: 10,
        marginBottom: 10,
        backColor: Colors.black.withOpacity(0.09),
        borderRadius: 10,
        child: Column(
          children: [
            AppText(
              order.getTitle,
              style: TextStyle(
                fontFamily: FontFamily.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  !toMe ? "المحفظ" : "الطالب",
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                  ),
                ),
                SubUserDescription(
                  fullName: user.fullName,
                  id: user.id,
                  profilePic: user.profilePic,
                  goToUserPage: true,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Helper.buildInfo(Icons.numbers, "رقم الطلب", "${order.number}"),
            const SizedBox(height: 10),
            Helper.buildInfo(
              Icons.info,
              "حالة الطلب",
              Order.stateName(order.state),
            ),
          ],
        ),
      ),
    );
  }
}
