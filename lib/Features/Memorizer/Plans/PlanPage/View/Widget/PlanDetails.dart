import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/LoadingFailsWIdget.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/services/AppUser.dart';

import '../../../../../../Helper/Helper.dart';
import '../../Blocs/cubit/plan_page_cubit.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanPageCubit>();
    return Column(
      children: [
        if (Get.find<AppUser>().user!.id == cubit.plan.memorizerData.id)
          CustomContainer(
            width: double.infinity,
            verticalPadding: 15,
            horizontalPadding: 20,
            borderRadius: 10,
            backColor: const Color.fromRGBO(237, 237, 237, 1),
            child: Column(
              children: [
                AppText(
                  'تفاصيل خاصة للدورة',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Helper.buildInfo(
                  Icons.info,
                  "الحالة",
                  cubit.plan.state.name,
                ),
                const SizedBox(height: 10),
                Helper.buildInfo(
                  FontAwesomeIcons.ticket,
                  "كوبونات الخصم",
                  "${cubit.plan.promoCode.length} كوبون",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'تعديل',
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        verticalPadding: 5,
                        onTap: cubit.editPlan,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        backgroundColor: cubit.plan.state != PlanState.hidden
                            ? Colors.red
                            : Colors.green,
                        text: cubit.plan.state != PlanState.hidden
                            ? 'إخفاء الدورة'
                            : "إظهار الدورة",
                        icon: Icon(
                          cubit.plan.state != PlanState.hidden
                              ? Icons.clear
                              : Icons.remove_red_eye,
                          color: Colors.white,
                          size: 20,
                        ),
                        verticalPadding: 5,
                        horizontalPadding: 0,
                        onTap: cubit.deletePlan,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        CustomContainer(
          width: double.infinity,
          verticalPadding: 9,
          horizontalPadding: 20,
          borderRadius: 10,
          backColor: const Color.fromRGBO(237, 237, 237, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'تفاصيل الدورة',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    FontAwesomeIcons.lightbulb,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AppText(
                cubit.plan.description,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomContainer(
          width: double.infinity,
          verticalPadding: 15,
          horizontalPadding: 20,
          borderRadius: 10,
          backColor: const Color.fromRGBO(237, 237, 237, 1),
          child: Column(
            children: [
              Center(
                child: AppText(
                  'السعر',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              AppText(
                "\$${cubit.plan.afterDiscount ?? cubit.plan.price}",
                style: TextStyle(
                  fontFamily: FontFamily.black,
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
              if (cubit.plan.afterDiscount != null)
                AppText(
                  "بدلا من ${cubit.plan.price}",
                  style: TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const SizedBox(height: 10),
              if (cubit.plan.memorizerData.id != Get.find<AppUser>().user!.id)
                SizedBox(
                  width: 200,
                  child: CustomButton(
                    text: cubit.plan.orderid == null
                        ? 'طلب الدورة'
                        : "تم طلب الدورة",
                    textColor: cubit.plan.orderid == null
                        ? Colors.white
                        : Colors.black,
                    backgroundColor: cubit.plan.orderid == null
                        ? const Color.fromRGBO(40, 180, 41, 1)
                        : Colors.white,
                    icon: Icon(
                      cubit.plan.orderid == null
                          ? Icons.shopping_bag
                          : Icons.check,
                      color: cubit.plan.orderid == null
                          ? Colors.white
                          : Colors.black,
                    ),
                    verticalPadding: 5,
                    onTap: cubit.requestPlan,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomContainer(
          width: double.infinity,
          verticalPadding: 15,
          horizontalPadding: 20,
          borderRadius: 10,
          backColor: const Color.fromRGBO(237, 237, 237, 1),
          child: Column(
            children: [
              Center(
                child: AppText(
                  'معلومات عن الدورة',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Helper.buildInfo(
                Icons.timelapse_sharp,
                "مدة الدورة",
                "${cubit.plan.duration} يوم",
              ),
              const SizedBox(height: 10),
              Helper.buildInfo(
                Icons.flash_on_rounded,
                "حضرو الدورة",
                "${cubit.plan.students} طالب",
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomContainer(
          width: double.infinity,
          verticalPadding: 9,
          horizontalPadding: 20,
          borderRadius: 10,
          backColor: const Color.fromRGBO(237, 237, 237, 1),
          child: Column(
            children: [
              AppText(
                'شروط الدورة',
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              if (cubit.plan.preRequisites.isEmpty)
                const Center(
                  child: LoadingFailsWidget(
                    title: 'لا يوجد شروط',
                    image: 'empty-box.png',
                    imageWidth: 100,
                  ),
                )
              else
                ...cubit.plan.preRequisites.map(
                  (e) => CustomContainer(
                    width: double.infinity,
                    verticalPadding: 5,
                    horizontalPadding: 20,
                    marginBottom: 10,
                    borderRadius: 10,
                    backColor: Colors.white,
                    child: Row(
                      children: [
                        const Icon(Icons.check),
                        const SizedBox(width: 10),
                        Flexible(
                          child: AppText(
                            e,
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
