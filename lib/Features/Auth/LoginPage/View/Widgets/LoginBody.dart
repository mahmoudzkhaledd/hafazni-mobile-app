import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/LoginPage/Blocs/LoginCubit/login_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';

import '../../../EmailVerification/ForgetPasswordPage/View/ForgetPasswordPage.dart';


class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubit = context.read<LoginCubit>();
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: context.read<LoginCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppText(
                  'مرحبا بك مجددا في منصة حفظني',
                  textAlign: TextAlign.center,
                  style: TextStyles.headerStyle.copyWith(fontSize: 25),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                hintText: 'الايميل',
                icon: FontAwesomeIcons.at,
                onChanged: (e) => cubit.email = e,
                isEmail: true,
                validator: (value) {
                  if (value == null || !Helper.isValidEmail(value)) {
                    return "من فضلك ادخل ايميل صالح";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomTextBox(
                    hintText: 'الباسورد',
                    onChanged: (e) => cubit.password = e,
                    icon: FontAwesomeIcons.lock,
                    isPassword: !context.read<LoginCubit>().showPassword,
                    showEyeIcon: true,
                    isPasswordInput: true,
                    onChangeVisability:
                        context.read<LoginCubit>().changePassword,
                    validator: (txt) => (txt != null && txt.length >= 8)
                        ? null
                        : "الباسورد يجب ان يكون على الاقل 8 احرف",
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => const ForgetPasswordPage());
                },
                child: AppText(
                  "هل نسيت كلمة المرور؟",
                  style: TextStyles.subHeaderStyle,
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'تسجيل الدخول',
                onTap: context.read<LoginCubit>().login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
