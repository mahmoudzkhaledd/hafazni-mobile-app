import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';

import '../../Blocs/cubit/forget_password_cubit.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CustomImage(
              'forgot-password.png',
              width: 200,
            ),
            const SizedBox(height: 50),
            AppText(
              'اكتب البريد الإلكتروني الخاص بك حتى يتم ارسال رسالة التفعيل عليه',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextBox(
              hintText: 'user@email.com',
              onChanged: (e) {},
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'إرسال',
              onTap: cubit.sendEmail,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
