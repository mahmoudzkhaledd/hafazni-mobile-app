import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ActiveUserAccount/Blocs/TargetCubit/target_cubit.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';

import 'package:hafazni/Models/Surah.dart';
import 'package:hafazni/Shared/SharedColors.dart';

import '../../../../../GeneralWidgets/AutoComplete.dart';
import '../../../../../GeneralWidgets/CustomSliverAppBar.dart';
import '../../../../../GeneralWidgets/CustomTimeLine.dart';
import 'SurahWidget.dart';
import 'TimingWidget.dart';

class AddUserTargetBody extends StatelessWidget {
  const AddUserTargetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TargetCubit>();
    return Column(
      children: [
        const CustomSliverAppBar(
          image: "photoActive.jpg",
          title: "ضع هدفا للوصول اليه",
          subTitle:
              "هدفك هو القوّة الدافعة التي توصلك إلى غايتك، والمفتاح الأساسي لتحقيق النجاح في جميع المجالات",
          height: 280,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomAutoComplete<Surah>(
                            onTap: cubit.confirmFirst,
                            onSubmit: cubit.submitFirst,
                            displayStringForOption: (s) => s.name,
                            hintText: 'من السورة ...',
                            loadData: cubit.loadSuras,
                          ),
                          const SizedBox(height: 20),
                          CustomAutoComplete<Surah>(
                            onTap: cubit.confirmSecond,
                            onSubmit: cubit.submitSecond,
                            displayStringForOption: (s) => s.name,
                            hintText: 'الى السورة ...',
                            loadData: cubit.loadSuras,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    CustomIconButton(
                      icon: Icons.check,
                      onTap: cubit.confirmSurah,
                      backColor: Colors.green,
                      verticalPadding: 10,
                      horizontalPadding: 10,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                BlocBuilder<TargetCubit, TargetState>(
                  builder: (context, state) {
                    return CustomTimeLine(
                      builder: (BuildContext context, int idx) {
                        if (idx == 0) {
                          return SurahWidget(
                            surah: cubit.first,
                            backColor: AppColors.containerColor,
                          );
                        } else if (idx == 2) {
                          return SurahWidget(
                            surah: cubit.second,
                            backColor: AppColors.containerColor,
                          );
                        }
                        return TimingWidget(
                          first: cubit.first,
                          second: cubit.second,
                          errorColor: Colors.red,
                          successColor: AppColors.mainColor,
                        );
                      },
                      iconBuilder: (BuildContext context, int idx) {
                        return CircleAvatar(
                          radius: 17,
                          backgroundColor: AppColors.mainColor,
                          child: Icon(
                            idx != 1 ? Icons.check : Icons.timelapse_outlined,
                            size: 20,
                          ),
                        );
                      },
                      separatorColor: Colors.grey,
                      itemCount: 3,
                      separatorWidth: 3,
                      separatorHeightBuilder: (e) => e != 1 ? 120 : 35,
                      horizontalSpace: 20,
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'حفظ',
                  onTap: cubit.save,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
