import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:intl/intl.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../GeneralWidgets/CustomButton.dart';
import '../../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../../Helper/Helper.dart';
import '../../../../../../Models/Order.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';
import '../../../../../Memorizer/Plans/PlanPage/View/PlanPage.dart';
import '../../Blocs/order_page_cubit.dart';

class OrderPageHeader extends StatelessWidget {
  const OrderPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderPageCubit>();
    final order = cubit.order;
    final currUserId = Get.find<AppUser>().user!.id;
    return Column(
      children: [
        AppText(
          'متابعة حالة الطلب',
          style: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        CustomContainer(
          verticalPadding: 20,
          horizontalPadding: 10,
          borderRadius: 10,
          backColor: Colors.black.withOpacity(0.1),
          width: double.infinity,
          child: Column(
            children: [
              Helper.buildInfo(
                Icons.date_range,
                'تاريخ الطلب',
                DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                    .format(order.createdAt),
              ),
              Helper.buildInfo(
                Icons.numbers,
                "رقم الطلب",
                '${order.number}',
              ),
              Helper.buildInfo(
                Icons.info,
                "حالة الطلب",
                Order.stateName(order.state),
              ),
              Helper.buildInfo(
                FontAwesomeIcons.dollarSign,
                "السعر النهائي",
                "${order.getFinalPrice.toStringAsFixed(2)}\$",
              ),
              if (cubit.order.promoCode != null)
                Helper.buildInfo(
                  FontAwesomeIcons.ticket,
                  "كوبون الخصم",
                  cubit.order.promoCode!.code,
                ),
              const SizedBox(height: 10),
              if (cubit.showPlanButton)
                CustomButton(
                  text: 'الذهاب للخطة',
                  verticalPadding: 5,
                  onTap: () {
                    Get.to(() => PlanPage(
                          plan: order.plan,
                          goToUserPage: true,
                        ));
                  },
                ),
              if (order.state == OrderState.accepted &&
                  currUserId == order.userFrom)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "بدء الدورة",
                      verticalPadding: 5,
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromRGBO(52, 45, 15, 1),
                      ),
                      textColor: const Color.fromRGBO(52, 45, 15, 1),
                      backgroundColor: const Color.fromRGBO(248, 216, 35, 1),
                      onTap: cubit.startPlan,
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              if (order.state != OrderState.canceled &&
                  order.userFrom == currUserId &&
                  order.state != OrderState.running)
                CustomButton(
                  text: "إلغاء الطلب",
                  verticalPadding: 5,
                  backgroundColor: Colors.red,
                  onTap: () => cubit.changeOrderState(OrderState.canceled),
                ),
              if (order.state == OrderState.canceled &&
                  order.userFrom == Get.find<AppUser>().user!.id)
                CustomButton(
                  text: "تعديل الطلب",
                  verticalPadding: 5,
                  icon: const Icon(
                    Icons.edit,
                    color: Color.fromRGBO(52, 45, 15, 1),
                  ),
                  textColor: const Color.fromRGBO(52, 45, 15, 1),
                  backgroundColor: const Color.fromRGBO(248, 216, 35, 1),
                  onTap: cubit.editOrder,
                ),
              if (order.memorizerTo == currUserId &&
                  order.state != OrderState.canceled &&
                  order.state != OrderState.running)
                Column(
                  children: [
                    CustomButton(
                      text: "قبول الطلب",
                      verticalPadding: 5,
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromRGBO(52, 45, 15, 1),
                      ),
                      textColor: const Color.fromRGBO(52, 45, 15, 1),
                      backgroundColor: const Color.fromRGBO(248, 216, 35, 1),
                      onTap: () => cubit.changeOrderState(OrderState.accepted),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "رفض الطلب",
                      verticalPadding: 5,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      textColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(180, 48, 45, 1),
                      onTap: () => cubit.changeOrderState(OrderState.refused),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
