import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:hafazni/Shared/AppColors.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';

import '../../Blocs/cubit/add_plan_cubit.dart';

class AddPlanBody extends StatelessWidget {
  const AddPlanBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPlanCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText('الإسم'),
            CustomTextBox(
              hintText: "الإسم",
              initialValue: cubit.plan.title,
              onChanged: (e) => cubit.plan.title = e,
              validator: (val) {
                if (val == null || val.isEmpty || val.length > 20) {
                  return "يجب ان يكون الاسم اقل من 20 حرف";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const AppText('الوصف'),
            Row(
              children: [
                Expanded(
                  child: CustomTextBox(
                    hintText: "الوصف",
                    maxLines: null,
                    initialValue: cubit.plan.description,
                    focusNode: cubit.focusNode,
                    onChanged: (e) => cubit.plan.description = e,
                  ),
                ),
                const SizedBox(width: 20),
                CustomIconButton(
                  icon: Icons.check,
                  verticalPadding: 10,
                  horizontalPadding: 10,
                  backColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  onTap: cubit.hideKeyboard,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const AppText('المدة'),
            CustomTextBox(
              hintText: "المدة",
              suffixIcon: const AppText(
                'يوم',
                textAlign: TextAlign.center,
              ),
              isNumber: true,
              initialValue: cubit.plan.duration.toString(),
              onChanged: (e) {
                cubit.plan.duration = int.tryParse(e) ?? 0;
              },
              validator: (val) {
                int? m = int.tryParse(val ?? "");
                if (val == null || val.isEmpty || m == null) {
                  return "يجب وضع مدة صالحة";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<AddPlanCubit, AddPlanState>(
              buildWhen: (previous, current) => current is AddPreqsState,
              builder: (context, state) {
                return CustomContainer(
                  width: double.infinity,
                  verticalPadding: 10,
                  horizontalPadding: 20,
                  borderRadius: 10,
                  backColor: const Color.fromRGBO(232, 232, 232, 1),
                  child: ListTile(
                    title: const AppText("متطلبات الدورة"),
                    leading: const Icon(FontAwesomeIcons.wandMagicSparkles),
                    subtitle: AppText(
                      cubit.plan.preRequisites.isEmpty
                          ? "لم يتم إضافة متطلبات"
                          : "تم إضافة ${cubit.plan.preRequisites.length}",
                    ),
                    onTap: () => cubit.showPreqsDialoge(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const AppText('سعر الدورة'),
            AppText(
              'سيتم حذف الكوبونات المختارة في حال تغيير السعر',
              style: TextStyles.subHeaderStyle,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              hintText: "سعر الدورة",
              isDecimal: true,
              initialValue: cubit.plan.price.toStringAsFixed(2),
              suffixIcon: const Icon(Icons.monetization_on),
              onChanged: cubit.setPlanPrice,
              validator: (val) {
                double? m = double.tryParse(val ?? "");
                if (val == null || val.isEmpty || m == null || m <= 0) {
                  return "يجب وضع سعر للدورة";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomContainer(
              width: double.infinity,
              verticalPadding: 10,
              horizontalPadding: 20,
              borderRadius: 10,
              backColor: const Color.fromRGBO(232, 232, 232, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'الخصومات',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextBox(
                    hintText: "السعر بعد الخصم",
                    isDecimal: true,
                    initialValue: "${cubit.plan.afterDiscount ?? ""}",
                    backgroundColor: Colors.white,
                    onChanged: (e) =>
                        cubit.plan.afterDiscount = double.tryParse(e),
                    validator: (val) {
                      if (val != null &&
                          val.isNotEmpty &&
                          double.parse(val) >= cubit.plan.price) {
                        return "يجب ان يكون سعر الدورة بعد الخصم اقل من قبله";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddPlanCubit, AddPlanState>(
                    buildWhen: (previous, current) =>
                        current is AddPromoCodesState,
                    builder: (context, state) {
                      return CustomContainer(
                        width: double.infinity,
                        verticalPadding: 0,
                        horizontalPadding: 20,
                        borderRadius: 10,
                        backColor: Colors.white,
                        child: ListTile(
                          title: DefaultTextStyle(
                            style: const TextStyle(),
                            child: AppText(
                              "كوبونات الخصم",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.bold,
                              ),
                            ),
                          ),
                          leading: const Icon(FontAwesomeIcons.ticket),
                          subtitle: AppText(
                            cubit.promoCodes.isEmpty
                                ? "لم يتم إضافة كوبونات خصم"
                                : "تم إضافة ${cubit.promoCodes.length}",
                          ),
                          onTap: () => cubit.showCouponsDialoge(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'حفظ',
                    verticalPadding: 5,
                    backgroundColor: Colors.green,
                    onTap: () => cubit.uploadPlan(PlanState.saved),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    text: 'ارسال للمراجعة',
                    verticalPadding: 5,
                    backgroundColor: Colors.blueAccent,
                    onTap: () => cubit.uploadPlan(PlanState.pending),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
