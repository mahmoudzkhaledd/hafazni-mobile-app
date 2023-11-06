import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomCheckBox.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:intl/intl.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../Blocs/AddCouponCubit/add_coupon_cubit.dart';

class AddCouponBody extends StatelessWidget {
  const AddCouponBody({super.key});
  Widget buildDate(String text, String subTitle) => CustomContainer(
        verticalPadding: 10,
        horizontalPadding: 20,
        borderRadius: 10,
        backColor: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text,
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                AppText(
                  subTitle,
                  style: TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: FontFamily.bold,
      fontSize: 15,
      color: Colors.black,
    );
    final cubit = context.read<AddCouponCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'إسم الكوبون',
              style: textStyle,
            ),
            CustomTextBox(
              hintText: 'إسم الكوبون',
              englishOnly: true,
              onChanged: (e) => cubit.promoCode.name = e,
              validator: (val) {
                if (val == null || val.isEmpty || val.length > 20) {
                  return "يجب ان يوكن الاسم اقل من 20 حرف";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            AppText(
              "الكود",
              style: textStyle,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextBox(
                    letterSpacing: 15,
                    maxLength: 8,
                    englishOnly: true,
                    spaces: false,
                    hintText: 'ABCDEFGH',
                    textAlign: TextAlign.center,
                    controller: cubit.textEditingController,
                    onChanged: (e) => cubit.promoCode.code = e,
                    validator: (val) {
                      if (val == null || val.length != 8) {
                        return "الكود يجب ان يتكون من 8 أحرف";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Center(
                  child: CustomIconButton(
                    verticalPadding: 5,
                    horizontalPadding: 5,
                    icon: Icons.refresh,
                    onTap: cubit.getRandomString,
                  ),
                ),
              ],
            ),
            AppText(
              'الخصم',
              style: textStyle,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextBox(
                    isNumber: true,
                    hintText: 'الخصم',
                    onChanged: cubit.changeDiscount,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "يجب وضع خصم للكوبون";
                      }
                      if (cubit.promoCode.percentage &&
                          (double.tryParse(val) ?? 0) > 100) {
                        return "لا يجب ان تتعدى نسبة الكوبون 100%";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<AddCouponCubit, AddCouponState>(
                  buildWhen: (previous, current) =>
                      current is ChangePercentageState,
                  builder: (context, state) {
                    return CustomCheckBox(
                      value: cubit.promoCode.percentage,
                      text: 'نسبة',
                      onChange: cubit.togglePrecentage,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<AddCouponCubit, AddCouponState>(
              buildWhen: (previous, current) => current is TryCouponState,
              builder: (context, state) {
                return CustomContainer(
                  borderRadius: 10,
                  backColor: Colors.black.withOpacity(0.09),
                  verticalPadding: 20,
                  horizontalPadding: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'تجربة الكوبون',
                        style: textStyle,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextBox(
                              hintText: 'ضع مبلغا',
                              isDecimal: true,
                              backgroundColor: Colors.white,
                              onChanged: (val) =>
                                  cubit.tryCoupon = double.tryParse(val),
                              errorText: cubit.tryCouponError,
                            ),
                          ),
                          const SizedBox(width: 20),
                          CustomIconButton(
                            icon: Icons.check,
                            verticalPadding: 17,
                            horizontalPadding: 17,
                            onTap: cubit.applyCoupon,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          AppText(
                            "بعد الخصم",
                            style: textStyle,
                          ),
                          const Spacer(),
                          AppText(
                            (cubit.tryCoupon == null ||
                                    cubit.promoCode.discount < 0)
                                ? "غير محدد"
                                : cubit.promoCode
                                    .applyCoupon(cubit.tryCoupon!)
                                    .toStringAsFixed(2),
                            style: textStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomContainer(
              borderRadius: 10,
              backColor: Colors.black.withOpacity(0.09),
              verticalPadding: 20,
              horizontalPadding: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "بيانات إضافية",
                    style: textStyle,
                  ),
                  const SizedBox(height: 10),
                  CustomTextBox(
                    isNumber: true,
                    backgroundColor: Colors.white,
                    hintText: 'اقصى عدد مستخدمين',
                    onChanged: (e) =>
                        cubit.promoCode.maxUsers = int.tryParse(e),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddCouponCubit, AddCouponState>(
                    buildWhen: (previous, current) =>
                        current is ChangeCouponDateState,
                    builder: (context, state) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => cubit.chooseDate(true),
                            child: buildDate(
                              DateFormat('yyyy-MM-dd')
                                  .format(cubit.promoCode.startingDate ??
                                      DateTime.now())
                                  .toString(),
                              "تاريخ البدء",
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => cubit.chooseDate(false),
                            child: buildDate(
                              cubit.promoCode.endingDate != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(cubit.promoCode.endingDate!)
                                      .toString()
                                  : "غير محدد",
                              "تاريخ الإنتهاء",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'إضافة',
              onTap: cubit.addCoupon,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
