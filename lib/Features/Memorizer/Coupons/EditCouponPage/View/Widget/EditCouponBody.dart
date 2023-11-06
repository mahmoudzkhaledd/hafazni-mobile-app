import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:intl/intl.dart';

import '../../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../Blocs/cubit/edit_coupon_cubit.dart';


class EditCouponBody extends StatelessWidget {
  const EditCouponBody({super.key});

  Widget buildDate(String text, String subTitle) => CustomContainer(
        verticalPadding: 10,
        horizontalPadding: 20,
        borderRadius: 10,
        backColor: const Color.fromRGBO(247, 247, 247, 1),
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

  Widget buildDetail(Widget icon, String title, String data) => CustomContainer(
        verticalPadding: 8,
        horizontalPadding: 20,
        borderRadius: 10,
        marginBottom: 15,
        backColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 10),
                AppText(
                  title,
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            AppText(
              data,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditCouponCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomContainer(
            verticalPadding: 20,
            horizontalPadding: 20,
            borderRadius: 10,
            backColor: const Color.fromRGBO(247, 247, 247, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetail(
                  const Icon(Icons.code),
                  "الكود",
                  cubit.promoCode.code,
                ),
                buildDetail(
                  const Icon(Icons.person),
                  "عدد المستخدمين",
                  cubit.promoCode.users.toString(),
                ),
                buildDetail(
                  const Icon(Icons.percent),
                  "الخصم",
                  "${cubit.promoCode.discount.toStringAsFixed(2)}${cubit.promoCode.percentage ? "%" : "\$"}",
                ),
                BlocBuilder<EditCouponCubit, EditCouponState>(
                  buildWhen: (previous, current) =>
                      current is ChangeEditCouponStateState,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetail(
                          const Icon(Icons.info),
                          "الحالة",
                          cubit.promoCode.valid ? "صالح" : "متوقف",
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: CustomButton(
                                text: cubit.promoCode.valid ? 'ايقاف' : "تفعيل",
                                verticalPadding: 3,
                                backgroundColor: cubit.promoCode.valid
                                    ? Colors.redAccent
                                    : Colors.green,
                                fontSize: 14,
                                icon: Icon(
                                  cubit.promoCode.valid
                                      ? FontAwesomeIcons.stopwatch
                                      : Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onTap: cubit.stopCoupon,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 120,
                              child: CustomButton(
                                text: "حذف",
                                verticalPadding: 3,
                                backgroundColor: Colors.red,
                                fontSize: 14,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onTap: cubit.deleteCoupon,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: cubit.formKey,
            child: Column(
              children: [
                CustomTextBox(
                  validator: (val) {
                    if (val == null || val.length > 20 || val.isEmpty) {
                      return "اسم الكوبون يجب ان يكون اقل من 20 حرف";
                    }
                    return null;
                  },
                  initialValue: cubit.promoCode.name,
                  backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
                  hintText: "الإسم",
                  onChanged: (e) => cubit.promoCode.name = e,
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                  isNumber: true,
                  validator: (e) {
                    int? val = int.tryParse(e ?? "");
                    if (val != null && val <= cubit.promoCode.users) {
                      return "اقصي عدد يجب ان يكون اكبر من المسخدمين الحاليين";
                    }
                    return null;
                  },
                  initialValue: "${cubit.promoCode.maxUsers ?? ""}",
                  backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
                  hintText: 'اقصى عدد مستخدمين',
                  onChanged: (e) => cubit.promoCode.maxUsers = int.tryParse(e),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<EditCouponCubit, EditCouponState>(
            buildWhen: (previous, current) =>
                current is ChangeEditCouponDateState,
            builder: (context, state) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => cubit.chooseDate(true),
                    child: buildDate(
                      DateFormat('yyyy-MM-dd')
                          .format(
                              cubit.promoCode.startingDate ?? DateTime.now())
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
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'حفظ',
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onTap: cubit.save,
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
