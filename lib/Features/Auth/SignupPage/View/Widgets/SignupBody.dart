import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/Features/Auth/SignupPage/Blocs/SignupCubit/signup_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomCheckBox.dart';
import 'package:hafazni/GeneralWidgets/CustomRadioButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedColors.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';
import 'package:intl/intl.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              AppText(
                'مرحبا بك في منصة حفظني',
                style: TextStyles.headerStyle,
                textAlign: TextAlign.center,
              ),
              AppText(
                "يرجى ادخال البيانات المطلوبة لانشاء حساب جديد",
                style: TextStyles.subHeaderStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              CustomTextBox(
                hintText: "الاسم الاول",
                icon: FontAwesomeIcons.signature,
                onChanged: (e) => cubit.user.firstName = e,
                validator: (txt) {
                  if (txt == null || txt.length < 3) {
                    return "اسم المستخدم يجب ان يكون بين 3 و 32 حرف";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "الاسم الاخير",
                icon: FontAwesomeIcons.signature,
                onChanged: (e) => cubit.user.lastName = e,
                validator: (txt) {
                  if (txt == null || txt.length < 3) {
                    return "اسم المستخدم يجب ان يكون بين 3 و 32 حرف";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "الايميل",
                icon: FontAwesomeIcons.at,
                onChanged: (e) => cubit.user.email = e,
                validator: (txt) {
                  if (txt == null || !Helper.isValidEmail(txt)) {
                    return "من فضلك ادخل ايميل صالح";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangePasswordVisabilityState,
                builder: (context, state) => Column(
                  children: [
                    CustomTextBox(
                      hintText: "الباسورد",
                      icon: FontAwesomeIcons.lock,
                      showEyeIcon: true,
                      isPassword: !cubit.showPassword,
                      onChangeVisability: cubit.changePasswordVisability,
                      onChanged: (e) => cubit.user.password = e,
                      validator: (txt) {
                        if (txt == null || txt.length < 8) {
                          return "يجب الا يقل طول كلمة المرور عن 8 احرف";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextBox(
                      hintText: "تأكيد الباسورد",
                      icon: FontAwesomeIcons.lock,
                      isPassword: true,
                      validator: (txt) {
                        if (txt != cubit.user.password) {
                          return "لا يوجد تطابق في كلمات المرور";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomTextBox(
                hintText: "رقم الهاتف",
                icon: FontAwesomeIcons.phone,
                isNumber: true,
                onChanged: (e) => cubit.user.phone = e,
                validator: (txt) {
                  if (txt == null || txt.isEmpty) {
                    return "رقم الهاتف مطلوب";
                  }
                  if (txt.length > 30) {
                    return "الرجاء ادخال رقم هاتف صالح";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangeBirthdateState,
                builder: (context, state) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: const Icon(FontAwesomeIcons.cakeCandles),
                    onTap: cubit.changeUserBirthDate,
                    title: AppText(
                      DateFormat('yyyy-MM-dd')
                          .format(cubit.user.birthdate)
                          .toString(),
                    ),
                    subtitle: const AppText(
                      "تاريخ الميلاد",
                    ),
                    tileColor: AppColors.textBoxColor,
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial || current is ChangeCountryState,
                builder: (context, state) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: const Icon(FontAwesomeIcons.globe),
                    onTap: cubit.changeCountry,
                    title: AppText(
                      cubit.user.country.arabicName.isNotEmpty
                          ? cubit.user.country.arabicName
                          : "لم يتم التحديد",
                    ),
                    subtitle: const AppText(
                      "الدولة",
                    ),
                    tileColor: AppColors.textBoxColor,
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial || current is ChangeGenderState,
                builder: (context, state) {
                  return Row(
                    children: [
                      AppText(
                        "الجنس",
                        style: TextStyle(
                          fontFamily: FontFamily.bold,
                        ),
                      ),
                      CustomRadioButton<bool>(
                        text: "ذكر",
                        value: true,
                        groupValue: cubit.user.gender,
                        onChanged: cubit.changeUserGender,
                      ),
                      const SizedBox(width: 10),
                      CustomRadioButton<bool>(
                        text: "انثى",
                        value: false,
                        groupValue: cubit.user.gender,
                        onChanged: cubit.changeUserGender,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<SignupCubit, SignupState>(
                buildWhen: (previous, current) =>
                    previous is SignupInitial ||
                    current is ChangeConditionsState,
                builder: (context, state) {
                  return CustomCheckBox(
                    value: cubit.acceptConditions,
                    color: Colors.blueAccent,
                    text: "اقر على الشروط والاحكام",
                    onChange: cubit.changeConditions,
                  );
                },
              ),
              const SizedBox(height: 40),
              CustomButton(
                verticalPadding: 15,
                text: "انشاء حساب جديد",
                onTap: cubit.signup,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
