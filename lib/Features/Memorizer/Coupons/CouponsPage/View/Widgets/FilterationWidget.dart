import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../../AddCouponPage/View/AddCouponPage.dart';
import '../../Blocs/cubit/view_coupons_cubit.dart';

class FilterationWidget extends StatelessWidget {
  const FilterationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: 10,
      horizontalPadding: 20,
      verticalPadding: 20,
      backColor: const Color.fromRGBO(251, 251, 251, 1),
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                'كوبونات الخصم',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(FontAwesomeIcons.ticket),
              const Spacer(),
              AppText(
                '[5]',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'الكل',
                borderRadius: 10,
                verticalPadding: 1,
                horizontalPadding: 20,
                backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                textColor: Colors.black,
                icon: const Icon(
                  Icons.done_all_sharp,
                  color: Colors.black,
                ),
                onTap: context.read<ViewCouponsCubit>().shoFilterDialoge,
              ),
              const SizedBox(width: 10),
              CustomButton(
                text: 'إضافة',
                borderRadius: 10,
                verticalPadding: 1,
                horizontalPadding: 30,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  Get.to(() => const AddCouponPage());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
