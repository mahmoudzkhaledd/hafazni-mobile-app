import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ActiveMemorizerAccountPage/Blocs/MemorizerAccountCubit/memorizer_account_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';
import 'package:hafazni/GeneralWidgets/CustomSliverAppBar.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Shared/AppColors.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';
import 'CertificantPicture.dart';
import 'ReadingsWidget.dart';

class ActiveMemorizerAccountBody extends StatelessWidget {
  const ActiveMemorizerAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    const double headderFontSize = 18;

    final cubit = context.read<MemorizerAccountCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSliverAppBar(
          image: 'download.jpeg',
          title: 'تفعيل حساب محفظ',
          subTitle:
              'الماهر بالقرآن مع السفرة الكرام البررة، والذي يقرأ القرآن ويتعتع فيه وهو عليه شاق له أجران',
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: BlocBuilder<MemorizerAccountCubit, MemorizerAccountState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "وصف المحفظ",
                      style: TextStyles.headerStyle.copyWith(
                        fontSize: headderFontSize,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextBox(
                            maxLines: null,
                            hintText: "اكتب عن نفسك",
                            initialValue: cubit.user.memorizerData == null
                                ? ""
                                : cubit.user.memorizerData!.describtion,
                            focusNode: cubit.focusNode,
                            onChanged: (e) => cubit.description = e,
                          ),
                        ),
                        const SizedBox(width: 20),
                        CustomIconButton(
                          icon: Icons.check,
                          iconColor: Colors.white,
                          onTap: cubit.submitText,
                          backColor: AppColors.mainColor,
                          verticalPadding: 10,
                          horizontalPadding: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppText(
                      "الإجازة",
                      style: TextStyles.headerStyle.copyWith(
                        fontSize: headderFontSize,
                      ),
                    ),
                    CertificantPicture(
                      fileUrl: cubit.imageUrl,
                      fileName: cubit.file == null ? null : cubit.file!.name,
                      onTap: cubit.viewImage,
                      onTapTop: cubit.onRemovePic,
                    ),
                    if (cubit.file != null && cubit.imageUrl == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: CustomButton(
                          verticalPadding: 5,
                          text: "رفع الصورة",
                          onTap: cubit.uploadImage,
                        ),
                      ),
                    const SizedBox(height: 20),
                    AppText(
                      "القراءات التي تجيدها",
                      style: TextStyles.headerStyle.copyWith(
                        fontSize: headderFontSize,
                      ),
                    ),
                    ReadingsWidget(
                      onCheck: cubit.onCheckReading,
                      checked: cubit.checkedReadings,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "ارسال للمراجعة",
                            onTap: () => cubit.saveData(false),
                            fontSize: 14,
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                            ),
                            backgroundColor:
                                const Color.fromRGBO(2, 161, 42, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            text: "حفظ",
                            onTap: () => cubit.saveData(true),
                            fontSize: 14,
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
